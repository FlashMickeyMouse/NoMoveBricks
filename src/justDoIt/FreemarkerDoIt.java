package justDoIt;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import freemarker.template.Configuration;
import freemarker.template.Template;

/**
 * 最常见的问题： 
 *     java.io.FileNotFoundException: xxx does not exist. 解决方法：要有耐心
 *     FreeMarker jar 最新的版本（2.3.23）提示 Configuration 方法被弃用
 * 代码自动生产基本原理：
 *     数据填充 freeMarker 占位符
 */
public class FreemarkerDoIt {
    
    private static final String TEMPLATE_PATH = "src/templates";
    private static final String CLASS_PATH = "src";
    
    public static void doIt(Map<String, String> dataMap) {
        // step1 创建freeMarker配置实例
        Configuration configuration = new Configuration(Configuration.VERSION_2_3_28);
        Writer out = null;
        try {
            // step2 获取模版路径
        	configuration.setDefaultEncoding("UTF-8"); 
            configuration.setDirectoryForTemplateLoading(new File(TEMPLATE_PATH));
            // step3 创建数据模型
//            Map<String, Object> dataMap = new HashMap<String, Object>();
//            dataMap.put("packagePath", "xin.kingsman");
//            dataMap.put("TableName", "TsUser");
//            dataMap.put("tableName", "tsUser");
            // step4 加载模版文件
            Template template = configuration.getTemplate("controller.ftl");
            template.setOutputEncoding("UTF-8"); 
            // step5 生成数据
            String docPath = CLASS_PATH+"/"+StringUtils.join(dataMap.get("packagePath").toString().split("\\."), "/");
            System.out.println(docPath);
            String controllerDocPath =docPath+"/controller";
            File file = new File(controllerDocPath);
            if (!file.isDirectory()) {
            	file.mkdirs();
			}
            File controllerFile = new File(controllerDocPath +"/"+dataMap.get("TableName") +"Controller.java");
            out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(controllerFile),"UTF-8"));
            // step6 输出文件
            template.process(dataMap, out);
            
            
            template = configuration.getTemplate("service.ftl");
            String serviceDocPath =docPath+"/service";
             file = new File(serviceDocPath);
            if (!file.isDirectory()) {
            	file.mkdirs();
			}
            File serviceFile = new File(serviceDocPath +"/"+dataMap.get("TableName") +"Service.java");
            out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(serviceFile)));
            // step6 输出文件
            template.process(dataMap, out);
            
            
            
            template = configuration.getTemplate("serviceImpl.ftl");
            String serviceImplDocPath =docPath+"/service/impl";
             file = new File(serviceImplDocPath);
            if (!file.isDirectory()) {
            	file.mkdirs();
			}
            File serviceImplFile = new File(serviceImplDocPath +"/"+dataMap.get("TableName") +"ServiceImpl.java");
            out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(serviceImplFile)));
            // step6 输出文件
            template.process(dataMap, out);
            
            
            
            
            System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^文件创建成功 !");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (null != out) {
                    out.flush();
                }
                out.close();
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
    }

}