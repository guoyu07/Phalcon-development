<?php
namespace Application\Services\Mappers;

use Application\Modules\Rest\Exceptions\NotFoundException;
use \Phalcon\DI\InjectionAwareInterface;
use \Phalcon\Logger;
use \Phalcon\Logger\Adapter\Database as LoggerDatabase;
use Application\Models\Logs;

/**
 * Class LogsMapper. Actions above logs
 *
 * @package Application\Services
 * @subpackage Mappers
 * @since PHP >=5.4
 * @version 1.0
 * @author Stanislav WEB | Lugansk <stanisov@gmail.com>
 * @copyright Stanislav WEB
 * @filesource /Application/Services/Mappers/LogMapper.php
 */
class LogMapper extends LoggerDatabase
    implements InjectionAwareInterface {

    /**
     * Available log code
     *
     * @var array $codes
     */
    private $codes = [
        Logger::ALERT,
        Logger::CRITICAL,
        Logger::DEBUG,
        Logger::ERROR,
        Logger::INFO,
        Logger::NOTICE,
        Logger::WARNING
    ];

    /**
     * Dependency injection container
     *
     * @var \Phalcon\DiInterface $di;
     */
    protected $di;

    /**
     * Errors array
     *
     * @var array $errors;
     */
    private $errors = [];

    /**
     * Init logger connector
     *
     * @param \Phalcon\Db\Adapter\Pdo\Mysql $connection
     * @throws \Phalcon\Logger\Exception
     */
    public function __construct(\Phalcon\Db\Adapter\Pdo\Mysql $connection, \Phalcon\DiInterface $di) {

        $this->setDi($di);
        $dispatcher = $di->get('dispatcher');

        if(empty($dispatcher->getModuleName()) === true) {
            $dispatcher->setModuleName('Global');
        }

        parent::__construct($dispatcher->getModuleName(), [
            'db'    => $connection,
            'table' => (new Logs())->getSource()
        ]);
    }

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
     * Get dependency container
     *
     * @return \Phalcon\DiInterface
     */
    public function getDi()
    {
        return $this->di;
    }

    /**
     * Get instance of polymorphic object
     *
     * @return Logs
     */
    public function getInstance() {
        return new Logs();
    }

    /**
     * Read logs
     *
     * @param array $credentials credentials
     * @return mixed
     */
    public function read(array $credentials = []) {

        $result = $this->getInstance()->find($credentials);
        return $result;
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
     * Log save handler
     *
     * @param string $message
     * @param int $code
     */
    public function save($message, $code) {

        if(array_key_exists($code, $this->codes) === true) {

            $this->log($message, $code);
        }
        else {
            throw new NotFoundException([
                'LOG_CODE_NOT_FOUND' => 'Logger code not found'
            ]);
        }
    }










    /**
     * Create log record
     *
     * @param array $data
     * return boolean
     */
    public function create(array $data) {

    }

    /**
     * Edit log record
     *
     * @param int $id
     * @param array $data
     */
    public function update($id, array $data) {

    }

    /**
     * Delete log record
     *
     * @param int      $id
     * @return boolean
     */
    public function delete($id) {

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
}