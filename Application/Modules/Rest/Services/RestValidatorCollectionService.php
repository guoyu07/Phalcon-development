<?php
namespace Application\Modules\Rest\Services;

use Phalcon\Filter;
use Application\Modules\Rest\Aware\RestValidatorCollectionsProvider;
use Application\Modules\Rest\Validators\QueryValidator;
use Application\Modules\Rest\Validators\ResultSetValidator;

/**
 * Class RestValidatorCollectionService. Rest validator's collections
 *
 * @package Application\Modules\Rest
 * @subpackage Services
 * @since PHP >=5.4
 * @version 1.0
 * @author Stanislav WEB | Lugansk <stanisov@gmail.com>
 * @copyright Stanislav WEB
 * @filesource /Application/Modules/Rest/Services/RestValidatorCollectionService.php
 */
class RestValidatorCollectionService extends RestValidatorCollectionsProvider {

    /**
     * Request rules
     *
     * @var array $params;
     */
    private $params  = [];

    /**
     * Initialize filter
     * Setup request input parameters
     * Valid all level request by collections
     *
     * @param \Phalcon\Http\Request $request
     * @return RestValidatorCollectionService
     */
    public function filter(\Phalcon\Http\Request $request) {


        $collection = $this->getCollection();
        $this->setParams($request)->setRequest($request);

        foreach($collection as $valid) {
            (new $valid())->run($this->getDi(), $this->getRules(), $this->getParams());
        }

        return $this;
    }

    /**
     * Set possible request params
     *
     * @param \Phalcon\Http\Request $request
     * @return RestValidatorCollectionService
     */
    public function setParams(\Phalcon\Http\Request $request)
    {
        // find primary
        $primary= [];

        if(array_key_exists('id', $this->getDispatcher()->getParams())) {
            $primary = [
                "id = ?0",
                "bind" => [$this->getDispatcher()->getParam('id')],
            ];
        }

        $data = ($request->isPut()) ? array_merge($request->getPut(), $request->get()) : $request->get();

        $this->params = $this->filterParams(array_merge(
            $primary, $data), ['trim']);

        return $this;
    }

    /**
     * Get request params
     *
     * @return array $params
     */
    public function getParams()
    {
        return $this->params;
    }

    /**
     * Filter request params
     *
     * @param array $params
     * @param string $function
     * @example <code>
     *              <?php $this->filterParams($params, ['trim']); ?>
     *          </code>
     */
    public function filterParams(array $params, array $filters)
    {
        $filter = new Filter();

        if(isset($params['_url'])) {
            unset($params['_url']);
        }

        return array_map(function ($value) use ($filter, $filters) {

            foreach ($filters as $func) {
                $value = $filter->sanitize($value, $func);
            }

            return $value;
        }, $params);
    }

    /**
     * Request validator
     *
     * @throws \Application\Modules\Rest\Exceptions\InternalServerErrorException
     */
    public function validate() {
        $qv = new QueryValidator($this->getDi());
        $qv->validate($this->getRules(), $this->getParams());
    }

    /**
     * Response resolver
     *
     * @param mixed $responseData
     */
    public function resolve($responseData) {

        $rs = new ResultSetValidator($this->getDi());
        $rs->validate($responseData);
        $this->setResponse($rs->getResult());
    }
}