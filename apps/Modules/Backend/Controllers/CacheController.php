<?php
namespace Modules\Backend\Controllers;
use \Phalcon\Mvc\View;

/**
 * Class CacheController
 * @package 	Backend
 * @subpackage 	Modules\Backend\Controllers
 * @since PHP >=5.4
 * @version 1.0
 * @author Stanislav WEB | Lugansk <stanisov@gmail.com>
 * @filesource /apps/Modules/Backend/Controllers/system/CacheController.php
 */
class CacheController extends ControllerBase
{
	/**
	 * Controller name
	 * @use for another Controllers to set views , paths
	 * @const
	 */
	const NAME	=	'Cache';

	private
		/**
		 * Available cache engines to review
		 * @var array
		 */
		$_engines	=	['apc' => true, 'memcache' => true, 'filesystem' => true];

	/**
	 * initialize() Initialize constructor
	 * @access public
	 * @return null
	 */
	public function initialize()
	{
		parent::initialize();
		$this->tag->setTitle(' - '.DashboardController::NAME);
	}

	public function indexAction()
	{
		$this->tag->prependTitle(self::NAME);

		// add crumb to chain (name, link)
		$this->_breadcrumbs->add(DashboardController::NAME, $this->url->get(['for' => 'dashboard']))
			->add(self::NAME);
	}

	public function storageAction($param)
	{
		if(isset($this->_engines[$param]))
		{
			$this->tag->prependTitle(ucfirst($param));

			// add crumb to chain (name, link)
			$this->_breadcrumbs->add(DashboardController::NAME, $this->url->get(['for' => 'dashboard']))
				->add(self::NAME, $this->url->get('dashboard/cache'))
				->add(ucfirst($param));

			// call selected storage
			$class = "\\Libraries\\CacheManagement\\Storages\\".ucfirst($param);

			$storage = new $class($this->_config);

			$this->view->setVars([
				'status'	=>	$storage->getStorageStatus()
			]);
		}
	}
}