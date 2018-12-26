<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>title</title>
<link rel="stylesheet" type="text/css" href="./static/css/iview.css">
</head>
<body>
	<div id="app" >
		<i-button @click="showDrawer">新增</i-button>
				
		<template> 
			<i-Form :model="searchMap" label-position="left" :label-width="100">
					<#list fieldList  as field>
					<Form-Item label="${field}"> 
						<i-Input v-model="searchMap.${field}"></i-Input>
					</Form-Item> 
					</#list>
					<Form-Item> 
						<i-Button type="primary" @click="getListData(1,${tableName}vm.pageSize)">查询</i-Button>
						<i-Button type="primary" @click="${tableName}vm.searchMap={};getListData(1,${tableName}vm.pageSize)">清除</i-Button>
					</Form-Item>
			</i-Form> 
			<i-Table  :columns="columns" :data="listdata">
				<p slot="header">
		        <span style="font-size: 16px">列表</span>
		        </p>
		        <p slot="footer">
		        <span style="font-size: 16px">汇总栏目</span>
		        </p>
			</i-Table> 
			<Page :total="total" :page-size="pageSize" show-total @on-change="changePage" style="padding:10px;"></Page> 
		</template>
		
		<drawer title="编辑表单" width="100%" :mask-closable="false" @on-close="onDrawerClose"
			v-model="isShowDrawer"> 
			<template> <!-- {{${tableName}}} -->
				<i-Form :model="${tableName}" label-position="left" :label-width="100">
				<#list fieldList  as field>
					<Form-Item label="${field}"> 
						<i-Input v-model="${tableName}.${field}"></i-Input>
					</Form-Item> 
				</#list>
				<Form-Item> 
					<i-Button type="primary" @click="save${TableName}">保存</i-Button>
				</Form-Item> 
				</i-Form> 
			</template> 
		</drawer>
	</div>
</body>
<script type="text/javascript" src="./static/js/vue.min.js"></script>
<script type="text/javascript" src="./static/js/iview.js"></script>
<script type="text/javascript" src="./static/js/axios.js"></script>
<script>
	var ${tableName}vm = new Vue({
		el : '#app',
		data(){
			return  {
				 searchMap:{},
				 ${tableName}:{},
	             columns: [
	                <#list fieldList  as field>
					{
	                     title: '${field}',
	                     key: '${field}'
	                 },
					</#list>
	                 {
	                	 title: '操作',
						 key: 'action',
						 render: (h, params) => {
								return h('div', [
									h('Button', {
										props: {
											type: 'text',
											size: 'small'
										},
										　on: {　　　　　　　　　　
											click: () => {
												this.isShowDrawer = true;
												const that = this;
												this.get${TableName}ById(params.row.id,function(data){
													that.${tableName}=data;
												})
												
											}　　　　　　　　
										}
									}, '编辑'),
									h('Button', {
										props: {
											type: 'text',
											size: 'small'
										},
										　on: {　　　　　　　　　　
											click: () => {
												this.del${TableName}(params.row.id)
											}　　　　　　　　
										}
									}, '删除')
								]);
							}
					  }
	             ],
	             listdata: [],
	             total: 0,
				 pageSize: 3,
				 isShowDrawer:false,
			}
		},
		mounted: function() {
			 //定义两个拦截器，目前是用于Loading效果处理
			 axios.interceptors.request.use(config=> {
		        //可以添加请求前的 ---  Loading效果处理
		        this.$Loading.start();
		        return config;
		      }, error => {
		    	  this.$Loading.error();
		    	 return Promise.reject(error);
		     });
		      axios.interceptors.response.use(response=> {
		        //可以添加响应过后的 ---  效果处理
		        this.$Loading.finish();
		        return response;
		      }, error => {
		    	  this.$Loading.error();
		    	  return Promise.reject(error);
			   });
		      
		      const vm = this;
			  vm.getListData(1,vm.pageSize);
		},
		methods : {
			changePage: function(index) {
				this.getListData(index,this.pageSize);
			},
			getListData: function(pageNumber, pageSize) {
				const that = this;
				axios.get('./${tableName}/select${TableName}.do?pageNumber=' + pageNumber + '&pageSize=' + pageSize,{
			          params:that.searchMap
				}).then(
					function(response) {
						if(response.data.code=="0"){
							that.listdata= response.data.data.list;
							that.total = response.data.data.total
						}else{
							alert("加载失败")
						}
					},
					function() {
						console.log('请求失败处理');
					})
			},
			showDrawer(){
				this.isShowDrawer = true;
			},
			onDrawerClose(){
				this.${tableName} = {};
			},
			save${TableName}(){
				const that = this;
				axios.post('./${tableName}/save${TableName}.do',that.${tableName}).then(
						function(response) {
							if(response.data.code == 0){
								that.isShowDrawer = false;
								that.${tableName} = {};
								that.getListData(1,that.pageSize);
							}else{
								alert("保存失败");
							}
						},
						function() {
							console.log('请求失败处理');
						})
			},
			get${TableName}ById(id,callback){
				  axios.get('./${tableName}/get${TableName}ById.do?${tableName}Id='+id).then(
							function(response) {
								if(response.data.code==0){
									callback(response.data.data)
								}else{
									alert("获取失败！")
								}
							},
							function() {
								console.log('请求失败处理');
					        })
			},
			del${TableName}(id){
				  const that = this;
				  axios.get('./${tableName}/del${TableName}.do?id='+id).then(
							function(response) {
								if(response.data.code==0){
									alert("已删除！")
									that.getListData(1,that.pageSize);
								}else{
									alert("获取失败！")
								}
							},
							function() {
								console.log('请求失败处理');
					        })
			}
		
		}
	})
</script>
</html>