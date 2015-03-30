<?php
namespace Application\Services\Mappers;

use Application\Aware\ModelCrudAbstract;
use Application\Models\Users;
use Application\Models\UserRoles;
use Application\Models\UserAccess;

/**
 * Class UserMapper. Actions above users
 *
 * @package Application\Services
 * @subpackage Mappers
 * @since PHP >=5.4
 * @version 1.0
 * @author Stanislav WEB | Lugansk <stanisov@gmail.com>
 * @copyright Stanislav WEB
 * @filesource /Application/Services/Mappers/UserMapper.php
 */
class UserMapper extends ModelCrudAbstract {

    /**
     * Get instance of polymorphic object
     *
     * @return Users
     */
    public function getInstance() {
        return new Users();
    }

    /**
     * Read users
     *
     * @param array $credentials credentials
     * @return mixed
     */
    public function read(array $credentials = []) {

        $result = $this->getInstance()->find($credentials);
        return $result;
    }







    /**
     * Set user access token
     *
     * @param int $user_id Auth user ID
     * @param string $token Generated token
     * @param int $expire_date Token date expiry
     * @return UserAccess|bool
     */
    public function setAccessToken($user_id, $token, $expire_date)
    {
        $userAccess = new UserAccess();
        $userAccess->setUserId($user_id)->setToken($token)->setExpireDate($expire_date);
        $userAccess->save();
        return $userAccess;
    }

    /**
     * Get model attributes
     *
     * @return array
     */
    public function getAttributes()
    {
        $metaData = $this->getInstance()->getModelsMetaData();
        return $metaData->getAttributes($this->getInstance());
    }

    /**
     * Create user
     *
     * @param array $data
     * return boolean
     */
    public function create(array $data) {

    }

    /**
     * Create simple user
     *
     * @param array $data
     * @return Users|bool
     */
    public function createUser(array $data) {

        $userModel = new Users();
        $userModel->setRole(UserRoles::USER)
            ->setIp($this->getDi()->get('request')->getClientAddress())
            ->setUa($this->getDi()->get('request')->getUserAgent());

        foreach($data as $field => $value) {

            if($field === 'password') {
                $userModel->setPassword($value);
            }
            else {
                $userModel->{$field}   =   $value;
            }
        }

        if($userModel->save() === true) {

            return $userModel;
        }
        else {

            $this->setErrors($userModel->getMessages());
            return false;
        }
    }

    /**
     * Edit user
     *
     * @param int $user_id
     * @param array $data
     */
    public function update($user_id, array $data) {

        $userModel = new Users();
        $userModel->setId($user_id);
        foreach($data as $field => $value) {

            $userModel->{$field}   =   $value;
        }

        if($userModel->update() === true) {

            return true;
        }
        else {
            $this->setErrors($userModel->getMessages());

            return false;
        }
    }

    /**
     * Refresh coming user
     *
     * @param int $user_id
     * @param array $data
     */
    public function refresh($user_id, array $data) {

        $user = $this->getOne(['id' => $user_id]);
        $user->skipAttributes(['surname']);
        $refresh = $user->setUa($data['ua'])->setIp($data['ip'])->setDateLastvisit();

        if($refresh->save() === true) {
            return true;
        }
        else {
            $this->setErrors($user->getMessages());
            return false;
        }


    }

    /**
     * Update user password
     *
     * @param int $user_id
     * @param string $password
     */
    public function updatePassword($user_id, $password) {

        $userModel = new Users();

        $update =  $userModel->getReadConnection()
            ->update($userModel->getSource(), ['password'], [
                $this->getDi()->getShared('security')->hash($password)
            ], "id = ".(int)$user_id);

        if($update === true) {
            return true;
        }
        else {
            $this->setErrors($userModel->getMessages());

            return false;
        }
    }

    /**
     * Delete user
     *
     * @param int      $id
     * @return boolean
     */
    public function delete($id) {

        $userModel = new Users();

        return $userModel->getReadConnection()
            ->delete($userModel->getSource(), "id = ".(int)$id);
    }

    /**
     * Set errors message
     *
     * @param mixed $errors
     */
    public function setErrors($errors) {
        $this->errors = $errors;
    }

    /**
     * Get error messages
     *
     * @return mixed $errors
     */
    public function getErrors() {
        return $this->errors;
    }

    /**
     * Get access model
     *
     * @return UserAccess
     */
    public function getAccess() {
        return new UserAccess();
    }

    /**
     * Get roles model
     *
     * @return UserRoles
     */
    public function getRoles() {
        return new UserRoles();
    }

    /**
     * Get user by credential
     *
     * @param array key=>value $credential
     * @return \Application\Models\Users $user
     */
    public function getOne(array $credential)
    {
        if(empty($credential) === false) {
            $user = (new Users())->findFirst([
                "".key($credential)." = ?0",
                "bind" => [$credential[key($credential)]],
            ]);

            return $user;
        }

        return false;
    }

    /**
     * Get users by condition
     *
     * @param array $params
     * @return \Phalcon\Mvc\Model
     */
    public function getList(array $params = [])
    {
        return Users::find($params);
    }

    /**
     *
     * Get access token by credential
     *
     * @param array $credential key => value
     * @return \Phalcon\Mvc\Model
     */
    public function getAccessTokenByCredential(array $credential)
    {
        $userAccess = new UserAccess();

        return $userAccess->findFirst([
            "".key($credential)." = ?0",
            "bind" => [$credential[key($credential)]],
        ]);
    }

    /**
     *
     * Remove access token by credential
     *
     * @param array $credential key => value
     * @return \Phalcon\Mvc\Model
     */
    public function deleteAccessTokenByCredential(array $credential)
    {
        $userAccess = new UserAccess();

        return $userAccess->findFirst([
            "".key($credential)." = ?0",
            "bind" => [$credential[key($credential)]],
        ])->delete();
    }
}