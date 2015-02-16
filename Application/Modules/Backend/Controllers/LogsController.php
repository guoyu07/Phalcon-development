<?php
namespace Application\Modules\Backend\Controllers;

use Application\Models\Logs;
use Phalcon\Mvc\View;

/**
 * Class LogsController
 *
 * @package    Application\Modules\Backend
 * @subpackage    Controllers
 * @since PHP >=5.4
 * @version 1.0
 * @author Stanislav WEB | Lugansk <stanisov@gmail.com>
 * @filesource /Application/Modules/Backend/Controllers/LogsController.php
 */
class LogsController extends ControllerBase
{
    /**
     * Controller name
     *
     * @use for another Controllers to set views , paths
     * @const
     */
    const NAME = 'Logs';

    /**
     * Cache key
     *
     * @use for every action
     * @access public
     */
    public $cacheKey = false;

    /**
     * initialize() Initialize constructor
     *
     * @access public
     * @return null
     */
    public function initialize()
    {

        parent::initialize();
        $this->tag->setTitle(' - ' . DashboardController::NAME);

        // create cache key
        $this->cacheKey = md5(\Application\Modules\Backend::MODULE . self::NAME . $this->router->getControllerName() . $this->router->getActionName());

        $this->breadcrumbs->add(DashboardController::NAME, $this->url->get(['for' => 'dashboard']));
    }

    /**
     * Get list of all pages
     *
     * @return null
     */
    public function indexAction()
    {
        $title = ucfirst(self::NAME);
        $this->tag->prependTitle($title);

        // add crumb to chain (name, link)

        $this->breadcrumbs->add($title);

        // get all records

        $logs = Logs::find();

        $this->view->setVars([
            'items' => $logs,
            'title' => $title,
        ]);
    }
}

