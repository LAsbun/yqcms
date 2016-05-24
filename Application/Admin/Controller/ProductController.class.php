<?php
/**
 * Created by PhpStorm.
 * User: sws
 * Date: 5/23/16
 * Time: 5:58 PM
 */
namespace Admin\Controller;

use Think\Controller;
class ProductController extends  Controller
{

    public function index()
    {

        // 获取一级分类（name 和 id）
        $protype = D('firtype');
        $protype_lists = [];

        $protype_lists = $protype->field('firtype_id,firtype_name')->select();


        // 获取二级分类
        $data = D('sectype');
        foreach ($protype_lists as $key => $val) {
//            var_dump($val);
            $protype_lists[$key]["sec"] = $data->field('sectype_id, sectype_name')->where("sectype_firtypeId = %d", $val['firtype_id'])->select();
            $protype_lists[$key]['url'] = U($val['firtype_controller'] . '/' . 'index');
        }
//        var_dump($protype_lists);

        $this->protype_lists = $protype_lists;

        $this->display();
    }

    public function add_pro()
    {
//        echo "dsads";
        $this->display();
    }

    public function upload()
    {
//        echo var_dump($_POST);
        $upload = new \Think\Upload();// 实例化上传类
        $upload->maxSize = 8388608;// 设置附件上传大小
        $upload->exts = array('jpg', 'gif', 'png', 'jpeg');// 设置附件上传类型
        $upload->rootPath = './Public/'; // 设置附件上传根目录
        $upload->savePath = 'image/'; // 设置附件上传（子）目录
        $upload->subName = array('date', 'Y-m');//子目录创建方式，[0]-函数名，[1]-参数，多个参数使用数组
        // 上传文件
        $info = $upload->upload();
        if (!$info) {// 上传错误提示错误信息
            $a = array('error' => 1, 'message' => $upload->getError());
            echo json_encode($a, JSON_UNESCAPED_UNICODE);
        } else {// 上传成功。将上传的信息传入前端的review_pic函数

            $url = "/yqcms/Public/" . $info['photo']['savepath'] . $info['photo']['savename'];
            $image_name = $info['photo']['savename'];
            $a = array('error' => 0, 'image_path' => $url, 'image_name' => $image_name);
            echo json_encode($a, JSON_UNESCAPED_UNICODE);

        }
    }
}