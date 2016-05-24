<?php
namespace Admin\Controller;
use Think\Controller;
//use Admin\Model\ProtypeModel;

class IndexController extends Controller {
    public function index(){

        // 获取一级分类（name 和 id）
        $protype = D('firtype');
        $protype_lists = [];

        $protype_lists = $protype->field('firtype_id,firtype_name')->select();


        // 获取二级分类
        $data = D('sectype');
        foreach($protype_lists as $key => $val){
//            var_dump($val);
            $protype_lists[$key]["sec"] = $data->field('sectype_id, sectype_name')->where("sectype_firtypeId = %d", $val['firtype_id'])->select();
            $protype_lists[$key]['url'] = U($val['firtype_controller'].'/'.'index');
        }
//        var_dump($protype_lists);

        $this->protype_lists = $protype_lists;

        $this->display();
    }
}