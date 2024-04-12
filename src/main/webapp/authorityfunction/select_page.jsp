<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>fallElove Product Manage</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
	crossorigin="anonymous" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
	integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />

<style>
table#table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
	border: 3px ridge Gray;
	height: 80px;
	text-align: center;
}

table#table-1 h4 {
	color: blue;
	display: block;
	margin-bottom: 1px;
}

h4 {
	color: blue;
	display: inline;
}
</style>

</head>

<body bgcolor='white'>

	<table id="table-1">
		<tr>
			<td>
				<h3>�ӫ~�޲z����</h3>
				<h4>
					<a class="icon-link" href="select_page.jsp">
						<i class="fa-solid fa-house">����</i>
					</a>
				</h4>
			</td>
		</tr>
	</table>

	<p>This is the Home page for FallELove Product Management</p>

	<h3>��Ƭd��:</h3>

	<%-- ���~���C --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">�Эץ��H�U���~:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<ul>
		<li><a href='listAllProduct.jsp'>List</a> all Products. <br> <br></li>



		<li>
			<FORM METHOD="post" ACTION="product.do">
				<b>��J�ӫ~�s�� (�q1�}�l):</b> <input type="text" name="pNo">
				<input type="hidden" name="action" value="getOne_For_Display">
				<input type="submit" value="�e�X">
			</FORM>
		</li>

		<jsp:useBean id="productSvc" scope="page"
			class="com.ren.product.service.ProductServiceImpl" />

		<li>
			<FORM METHOD="post" ACTION="product.do">
				<b>��ܰӫ~�s��:</b> <select size="1" name="pNo">
					<c:forEach var="productVO" items="${productSvc.all}">
						<option value="${productVO.pNo}">${productVO.pNo}
					</c:forEach>
				</select> <input type="hidden" name="action" value="getOne_For_Display">
				<input type="submit" value="�e�X">
			</FORM>
		</li>

		<li>
			<FORM METHOD="post" ACTION="product.do">
				<b>��ܰӫ~�W��:</b> <select size="1" name="pNo">
					<c:forEach var="productVO" items="${productSvc.all}">
						<option value="${productVO.pNo}">${productVO.pName}
					</c:forEach>
				</select> <input type="hidden" name="action" value="getOne_For_Display">
				<input type="submit" value="�e�X">
			</FORM>
		</li>
	</ul>


	<h3>�ӫ~�s�W</h3>
	<ul>
		<li><a href='addProduct.jsp'>Add</a> a new Product.</li>
	</ul>

</body>
</html>