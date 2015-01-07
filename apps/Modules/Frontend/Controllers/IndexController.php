<?php
namespace Modules\Frontend\Controllers;

/**
 * Class IndexController
 * @package    Frontend
 * @subpackage    Modules\Frontend\Controllers
 * @since PHP >=5.4
 * @version 1.0
 * @author Stanislav WEB | Lugansk <stanisov@gmail.com>
 * @filesource /apps/Modules/Frontend/Controllers/IndexController.php
 */
class IndexController extends ControllerBase
{
    /**
     * initialize() Initialize constructor
     * @access public
     * @return null
     */
    public function initialize()
    {
        parent::initialize();
    }

    public function indexAction()
    {
        // add java scripts minified

        $this->assets->collection('footer-js')
            //->addJs('assets/frontend/'.strtolower($this->engine->getCode()).'/controllers/'.$this->router->getControllerName().'.js');
            ->addJs('assets/frontend/'.strtolower($this->engine->getCode()).'/controllers/index.js')
            ->addJs('assets/frontend/'.strtolower($this->engine->getCode()).'/controllers/about.js')
            ->addJs('assets/frontend/'.strtolower($this->engine->getCode()).'/controllers/blog.js')
            ->addJs('assets/frontend/'.strtolower($this->engine->getCode()).'/controllers/contact.js');
    }
}

