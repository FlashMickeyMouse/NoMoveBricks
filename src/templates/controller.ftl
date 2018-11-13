package ${packagePath}.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.github.pagehelper.PageInfo;

import xin.kingsman.VO.JsonDataResult;
import xin.kingsman.pojo.${TableName};
import xin.kingsman.pojo.${TableName}Example;
import xin.kingsman.service.${TableName}Service;

@RestController
@RequestMapping("/${tableName}")
public class ${TableName}Controller {
	@Autowired
	${TableName}Service ${tableName}Service;

	@RequestMapping(value = "/add${TableName}", method = RequestMethod.POST)
	private JsonDataResult add${TableName}(@RequestBody ${TableName} ${tableName}) {
		try {
			${tableName}Service.add${TableName}Selective(${tableName});
		} catch (Exception e) {
			e.printStackTrace();
			return new JsonDataResult().err();
		}
		return new JsonDataResult();
	}

	@RequestMapping("/del${TableName}")
	private JsonDataResult del${TableName}(String id) {
		try {
			${tableName}Service.delete${TableName}ById(id);
		} catch (Exception e) {
			e.printStackTrace();
			return new JsonDataResult().err();
		}
		return new JsonDataResult();
	}

	@RequestMapping("/select${TableName}")
	private JsonDataResult select${TableName}(Integer pageNumber, Integer pageSize) {
		${TableName}Example ${tableName}Example = new ${TableName}Example();
		PageInfo<${TableName}> select${TableName}PageInfoByExample = ${tableName}Service.select${TableName}PageInfoByExample(pageNumber,
				pageSize, ${tableName}Example);
		return new JsonDataResult(select${TableName}PageInfoByExample);
	}

	@RequestMapping("/update${TableName}")
	private JsonDataResult update${TableName}(@RequestBody ${TableName} ${tableName}) {
		try {
			${tableName}Service.update${TableName}ByIdSelective(${tableName});
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new JsonDataResult().err();
		}
		return new JsonDataResult();
	}

	@RequestMapping("/save${TableName}")
	private JsonDataResult save${TableName}(@RequestBody ${TableName} ${tableName}) {
		try {
			${tableName}Service.save${TableName}Selective(${tableName});
		} catch (Exception e) {
			e.printStackTrace();
			return new JsonDataResult().err();
		}
		return new JsonDataResult();
	}
}