package ${packagePath}.service;

import java.util.List;

import com.github.pagehelper.PageInfo;

import xin.kingsman.pojo.${TableName};
import xin.kingsman.pojo.${TableName}Example;

public interface ${TableName}Service {

	${TableName} select${TableName}ByPrimaryKey(${TableName} ${tableName});

	${TableName} select${TableName}ByPrimaryKey(String id);

	List<${TableName}> select${TableName}ListByExample(${TableName}Example ${tableName}Example);

	PageInfo<${TableName}> select${TableName}PageInfoByExample(int pageNumber, int pageSize, ${TableName}Example ${tableName}Example);

	long count${TableName}ByExample(${TableName}Example ${tableName}Example);

	int add${TableName}(${TableName} ${tableName});

	int add${TableName}(${TableName} ${tableName}, String id);

	int add${TableName}Selective(${TableName} ${tableName});

	int add${TableName}Selective(${TableName} ${tableName}, String id);

	int update${TableName}ById(${TableName} ${tableName});

	int update${TableName}ById(${TableName} ${tableName}, String id);

	int update${TableName}ByIdSelective(${TableName} ${tableName});

	int update${TableName}ByIdSelective(${TableName} ${tableName}, String id);

	int update${TableName}ByExample(${TableName} ${tableName}, ${TableName}Example ${tableName}Example);

	int update${TableName}ByExampleSelective(${TableName} ${tableName}, ${TableName}Example ${tableName}Example);

	int save${TableName}(${TableName} ${tableName});

	int save${TableName}Selective(${TableName} ${tableName});

	int delete${TableName}ById(String id);

	int delete${TableName}ById(${TableName} ${tableName});

	int delete${TableName}ByExample(${TableName}Example ${tableName}Example);
	
	${TableName} get${TableName}ById(String id);
}