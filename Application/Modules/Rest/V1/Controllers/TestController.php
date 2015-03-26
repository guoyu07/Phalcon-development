<?php
namespace Application\Modules\Rest\V1\Controllers;

/**
 * Class TestController
 *
 * @package    Application\Modules\Rest
 * @subpackage    Controllers
 * @since PHP >=5.4
 * @version 1.0
 * @author Stanislav WEB | Lugansk <stanisov@gmail.com>
 * @filesource /Application/Modules/Rest/Controllers/TestController.php
 */
class TestController extends ControllerBase {

    /**
     * Pages action
     */
    public function show500Action() {

        $this->rest->getUndefinedMethod();
    }
}