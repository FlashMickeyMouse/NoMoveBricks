package ${packagePath}.service.impl;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import xin.kingsman.mapper.${TableName}Mapper;
import xin.kingsman.pojo.${TableName};
import xin.kingsman.pojo.${TableName}Example;
import xin.kingsman.service.${TableName}Service;

@Service
public class ${TableName}ServiceImpl implements ${TableName}Service {
	@Autowired
	${TableName}Mapper ${tableName}Mapper;

	// 查
	@Override
	public ${TableName} select${TableName}ByPrimaryKey(${TableName} ${tableName}) {
		return ${tableName}Mapper.selectByPrimaryKey(${tableName}.getId());
	}
	@Override
	public ${TableName} select${TableName}ByPrimaryKey(String id) {
		return ${tableName}Mapper.selectByPrimaryKey(id);
	}
	@Override
	public List<${TableName}> select${TableName}ListByExample(${TableName}Example ${tableName}Example) {
		return ${tableName}Mapper.selectByExample(${tableName}Example);
	}

	// 查 分页查
	@Override
	public PageInfo<${TableName}> select${TableName}PageInfoByExample(int pageNumber, int pageSize, ${TableName}Example ${tableName}Example) {
		PageHelper.startPage(pageNumber, pageSize);
		List<${TableName}> ${tableName}List = ${tableName}Mapper.selectByExample(${tableName}Example);
		PageInfo<${TableName}> ${tableName}PageInfo = new PageInfo<>(${tableName}List);
		return ${tableName}PageInfo;
	}

	// 查条数
	@Override
	public long count${TableName}ByExample(${TableName}Example ${tableName}Example) {
		return ${tableName}Mapper.countByExample(${tableName}Example);
	}

	// 增
	@Override
	public int add${TableName}(${TableName} ${tableName}) {
		${tableName}.setId(UUID.randomUUID().toString());
		return ${tableName}Mapper.insert(${tableName});
	}
	@Override
	public int add${TableName}(${TableName} ${tableName}, String id) {
		${tableName}.setId(id);
		return ${tableName}Mapper.insert(${tableName});
	}
	@Override
	public int add${TableName}Selective(${TableName} ${tableName}) {
		${tableName}.setId(UUID.randomUUID().toString());
		return ${tableName}Mapper.insertSelective(${tableName});
	}
	@Override
	public int add${TableName}Selective(${TableName} ${tableName}, String id) {
		${tableName}.setId(id);
		return ${tableName}Mapper.insertSelective(${tableName});
	}
	// 改
	@Override
	public int update${TableName}ById(${TableName} ${tableName}) {
		return ${tableName}Mapper.updateByPrimaryKey(${tableName});
	}
	@Override
	public int update${TableName}ById(${TableName} ${tableName}, String id) {
		${tableName}.setId(id);
		return ${tableName}Mapper.updateByPrimaryKey(${tableName});
	}
	@Override
	public int update${TableName}ByIdSelective(${TableName} ${tableName}) {
		return ${tableName}Mapper.updateByPrimaryKeySelective(${tableName});
	}
	@Override
	public int update${TableName}ByIdSelective(${TableName} ${tableName}, String id) {
		${tableName}.setId(id);
		return ${tableName}Mapper.updateByPrimaryKeySelective(${tableName});
	}

	// 改 按条件
	@Override
	public int update${TableName}ByExample(${TableName} ${tableName}, ${TableName}Example ${tableName}Example) {
		return ${tableName}Mapper.updateByExample(${tableName}, ${tableName}Example);
	}
	@Override
	public int update${TableName}ByExampleSelective(${TableName} ${tableName}, ${TableName}Example ${tableName}Example) {
		return ${tableName}Mapper.updateByExampleSelective(${tableName}, ${tableName}Example);
	}

	// 增改
	@Override
	public int save${TableName}(${TableName} ${tableName}) {
		// id是空去新增
		if (StringUtils.isEmpty(${tableName}.getId())) {
			return this.add${TableName}(${tableName});
		} else {
			return this.update${TableName}ById(${tableName});
		}
	}
	@Override
	public int save${TableName}Selective(${TableName} ${tableName}) {
		// id是空去新增
		if (StringUtils.isEmpty(${tableName}.getId())) {
			return this.add${TableName}Selective(${tableName});
		} else {
			return this.update${TableName}ByIdSelective(${tableName});
		}
	}

	// 删
	@Override
	public int delete${TableName}ById(String id) {
		return ${tableName}Mapper.deleteByPrimaryKey(id);
	}
	@Override
	public int delete${TableName}ById(${TableName} ${tableName}) {
		return ${tableName}Mapper.deleteByPrimaryKey(${tableName}.getId());
	}

	// 删 按条件
	@Override
	public int delete${TableName}ByExample(${TableName}Example ${tableName}Example) {
		return ${tableName}Mapper.deleteByExample(${tableName}Example);
	}
	
	@Override
	public ${TableName} get${TableName}ById(String id) {
		return ${tableName}Mapper.selectByPrimaryKey(id);
	}

}