<?php
namespace Application\Modules\Backend\Forms;

use Application\Models\Engines;
use Phalcon\Forms\Element;
use Phalcon\Forms\Form;
use Phalcon\Mvc\Model\Resultset\Simple as SimpleResultset;

/**
 * Class CategoryForm
 *
 * @package    Application\Modules\Backend
 * @subpackage    Form
 * @since PHP >=5.4
 * @version 1.0
 * @author Stanislav WEB | Lugansk <stanisov@gmail.com>
 * @filesource /Application/Modules/Backend/Forms/CategoryForm.php
 */
class CategoryForm extends Form
{

    /**
     * Available engines (multiple select)
     *
     * @var array
     */
    private $engines = [];

    /**
     * Available categories (for parent)
     * @var array
     */
    private $categories = [];

    /**
     * Initialize form's elements
     * @param null $obj
     * @param mixed $options
     */
    public function initialize($obj = null, $options)
    {
        $this->setEntity($this);

        // create engines array to Select node
        $this->engines = $this->getEngines($options['engines']);

        // create statuses array to Select node
        $this->categories = $this->getCategories($options['categories']);

        $this->add(new Element\Text("name", [
                'id' => 'name',
                'required' => 'true',
                'value' => (isset($options['default'])) ? $options['default']->getName() : ''
            ])
        );

        $this->add(new Element\TextArea("description", [
                'id' => 'description',
                'value' => (isset($options['default'])) ? $options['default']->getDescription() : ''
            ])
        );

        $this->add(new Element\File("logo", [
                'id' => 'logo-upload',
                'class' => 'file',
                'data-show-upload' => 'false',
                'data-show-caption' => 'true',
            ])
        );

        $this->add(new Element\Text("host", [
                'id' => 'host',
                'required' => 'true',
                'value' => (isset($options['default'])) ? $options['default']->getHost() : ''
            ])
        );

        $this->add(new Element\Text("code", [
                'id' => 'code',
                'required' => 'true',
                'value' => (isset($options['default'])) ? $options['default']->getCode() : ''
            ])
        );

        $this->add((new Element\Select("currency_id", $this->currencies))
                ->setDefault((isset($options['default'])) ? $options['default']->getCurrencyId() : 1)
        );

        $this->add((new Element\Select("status", $this->statuses))
                ->setDefault((isset($options['default'])) ? $options['default']->getStatus() : 1)
        );

        $this->add(new Element\Submit("save", [
                'id' => 'save',
            ])
        );
    }

    /**
     * Create currency list from database
     *
     * @param SimpleResultset $currency
     * @return array
     */
    public function getEngines(SimpleResultset $engines)
    {
        var_dump($engines->toArray()); exit;
        foreach ($currency as $v)
            $this->currencies[$v->getId()] = $v->getName();
        return $this->currencies;
    }
}