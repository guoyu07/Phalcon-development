<?php
namespace Application\Modules\Rest\Aware;

use Phalcon\DI\InjectionAwareInterface;
use \Phalcon\Text as Randomize;

/**
 * RestSecurityProvider. Rest API Security rules provider
 *
 * @package Application\Modules\Rest
 * @subpackage Aware
 * @since      PHP >=5.4
 * @version    1.0
 * @author     Stanislav WEB | Lugansk <stanisov@gmail.com>
 * @copyright  Stanislav WEB
 * @filesource /Application/Modules/Rest/Aware/RestSecurityProvider.php
 */
abstract class RestSecurityProvider implements InjectionAwareInterface {

    /**
     * @const Max pass length while recovery
     */
    const RECOVERY_PASS_LENGTH = 10;

    /**
     * Dependency injection container
     *
     * @var \Phalcon\DiInterface $di;
     */
    private $di;

    /**
     * System error messages
     *
     * @var mixed $error
     */
    private $error;

    /**
     * Set dependency container
     *
     * @param \Phalcon\DiInterface $di
     */
    public function setDi($di)
    {
        $this->di = $di;
    }

    /**
     * Get api config
     *
     * @return \Phalcon\Config
     */
    public function getConfig() {
        return $this->getDi()->get('RestConfig')->api;
    }

    /**
     * Get request plugin
     *
     * @return \Phalcon\Http\Request
     */
    public function getRequest() {
        return $this->getDi()->getShared('request');
    }

    /**
     * Get translate service
     *
     * @return \Application\Modules\Rest\Services\TranslateService
     */
    public function getTranslator() {
        return $this->getDI()->get('TranslateService')->assign('sign');
    }

    /**
     * User Mapper
     *
     * @return \Application\Services\Mappers\UserMapper
     */
    public function getUserMapper() {
        return $this->getDi()->get('UserMapper');
    }

    /**
     * Get security plugin
     *
     * @return \Phalcon\Security
     */
    public function getSecurity() {
        return $this->getDi()->getShared('security');
    }

    /**
     * Get dependency container
     *
     * @return \Phalcon\DiInterface
     */
    public function getDi()
    {
        return $this->di;
    }

    /**
     * Set error message
     *
     * @param string|array $message
     * @return null
     */
    public function setError($message) {

        $this->error = (is_array($message) === false) ? $this->getTranslator()->translate($message)
            : array_map(function($message) {
                return $this->getTranslator()->translate($message);
            },$message);
    }

    /**
     * Generate random string
     *
     * @return string
     */
    public function randomString() {
        return Randomize::random(Randomize::RANDOM_ALNUM, self::RECOVERY_PASS_LENGTH);
    }

    /**
     * Get auth error messages
     *
     * @return array
     */
    public function getError() {
        return $this->error;
    }

    /**
     * Authenticate user use credentials
     *
     * @param array $credentials
     * @return ResultSet
     */
    abstract public function authenticate(array $credentials);

    /**
     * Register new user from credentials
     *
     * @param array $credentials
     * @return ResultSet
     */
    abstract public function register(array $credentials);

    /**
     * Restore user access from credentials
     *
     * @param array $credentials
     * @return ResultSet
     */
    abstract public function restore(array $credentials);

    /**
     * Get user access token from header or request
     *
     * @return string $token
     */
    abstract protected function getToken();

    /**
     * Set user access token
     *
     * @param int $user_id Auth user ID
     * @param string $token Generated token
     * @param int $expire_date Token date expiry
     * @return bool
     */
    abstract protected function setToken($user_id, $token, $expire_date);

    /**
     * If user is authenticated?
     *
     * @return boolean
     */
    abstract protected function isAuthenticated();

    /**
     * If user has role?
     *
     * @param int $role
     * @return boolean
     */
    abstract protected function hasRole($role);
}