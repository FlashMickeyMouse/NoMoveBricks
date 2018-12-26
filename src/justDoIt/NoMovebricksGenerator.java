package justDoIt;
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.internal.DefaultShellCallback;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import justDoIt.FreemarkerDoIt;


/**
 * @author songhao
 *         <ol>
 *         <li>邮箱：sh_hq_123@163.com
 *         <li>手机号：131******51
 *         <li><em>拒绝搬砖，从我做起</em>
 *         </ol>
 * 
 */
public class NoMovebricksGenerator {

	public void generator() throws Exception {

		List<String> warnings = new ArrayList<String>();
		boolean overwrite = true;
		// 指定 逆向工程配置文件
		File configFile = new File("generatorConfig.xml");
		ConfigurationParser cp = new ConfigurationParser(warnings);
		Configuration config = cp.parseConfiguration(configFile);
		DefaultShellCallback callback = new DefaultShellCallback(overwrite);
		MyBatisGenerator myBatisGenerator = new MyBatisGenerator(config, callback, warnings);
		myBatisGenerator.generate(null);
	}
	
	public static void main(String[] args) throws Exception {
		try {
			NoMovebricksGenerator generatorSqlmap = new NoMovebricksGenerator();
			generatorSqlmap.generator();
		} catch (Exception e) {
			e.printStackTrace();
		}

		// 创建一个DocumentBuilderFactory的对象
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		// 创建DocumentBuilder对象
		DocumentBuilder db = dbf.newDocumentBuilder();
		// 通过DocumentBuilder对象的parser方法加载books.xml文件到当前项目下
		Document document = db.parse("generatorConfig.xml");
		String pojoPackagePath = document.getElementsByTagName("javaModelGenerator").item(0).getAttributes()
				.getNamedItem("targetPackage").getNodeValue();
		String packagePath = pojoPackagePath.substring(0, pojoPackagePath.lastIndexOf("."));
		System.out.println(packagePath);
		NodeList tableList = document.getElementsByTagName("table");
		for (int i = 0; i < tableList.getLength(); i++) {
			Node item = tableList.item(i);
			String camelName = camelName(item.getAttributes().getNamedItem("tableName").getNodeValue());
			System.out.println(camelName);
			Map<String, Object> dataMap = new HashMap<String, Object>();
			dataMap.put("packagePath", packagePath);
			dataMap.put("TableName", camelName.substring(0, 1).toUpperCase() + camelName.substring(1));
			dataMap.put("tableName", camelName);
			FreemarkerDoIt.doIt(dataMap);
		}

	}

	/**
	 * 将驼峰式命名的字符串转换为下划线大写方式。如果转换前的驼峰式命名的字符串为空，则返回空字符串。</br>
	 * 例如：HelloWorld->HELLO_WORLD
	 * 
	 * @param name
	 *            转换前的驼峰式命名的字符串
	 * @return 转换后下划线大写方式命名的字符串
	 */
	public static String underscoreName(String name) {
		StringBuilder result = new StringBuilder();
		if (name != null && name.length() > 0) {
			// 将第一个字符处理成大写
			result.append(name.substring(0, 1).toUpperCase());
			// 循环处理其余字符
			for (int i = 1; i < name.length(); i++) {
				String s = name.substring(i, i + 1);
				// 在大写字母前添加下划线
				if (s.equals(s.toUpperCase()) && !Character.isDigit(s.charAt(0))) {
					result.append("_");
				}
				// 其他字符直接转成大写
				result.append(s.toUpperCase());
			}
		}
		return result.toString();
	}

	/**
	 * 将下划线大写方式命名的字符串转换为驼峰式。如果转换前的下划线大写方式命名的字符串为空，则返回空字符串。</br>
	 * 例如：HELLO_WORLD->HelloWorld
	 * 
	 * @param name
	 *            转换前的下划线大写方式命名的字符串
	 * @return 转换后的驼峰式命名的字符串
	 */
	public static String camelName(String name) {
		StringBuilder result = new StringBuilder();
		// 快速检查
		if (name == null || name.isEmpty()) {
			// 没必要转换
			return "";
		} else if (!name.contains("_")) {
			// 不含下划线，仅将首字母小写
			return name.substring(0, 1).toLowerCase() + name.substring(1);
		}
		// 用下划线将原始字符串分割
		String camels[] = name.split("_");
		for (String camel : camels) {
			// 跳过原始字符串中开头、结尾的下换线或双重下划线
			if (camel.isEmpty()) {
				continue;
			}
			// 处理真正的驼峰片段
			if (result.length() == 0) {
				// 第一个驼峰片段，全部字母都小写
				result.append(camel.toLowerCase());
			} else {
				// 其他的驼峰片段，首字母大写
				result.append(camel.substring(0, 1).toUpperCase());
				result.append(camel.substring(1).toLowerCase());
			}
		}
		return result.toString();
	}

}
