<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ren.product.service.*" %>
<%@ page import="com.ren.product.model.ProductVO" %>
<%-- �����m�߱ĥ� EL ���g�k���� --%>

<%
    ProductServiceImpl productSvc = new ProductServiceImpl();
    List<ProductVO> list = productSvc.getAll();
    pageContext.setAttribute("list", list);
%>


<html>
<head>
    <title>�Ҧ����u��� - listAllProduct.jsp</title>

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
            crossorigin="anonymous"/>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
          integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>

    <style>
        table#table-1 {
            background-color: #CCCCFF;
            border: 2px solid black;
            text-align: center;
        }

        table#table-1 h4 {
            color: red;
            display: block;
            margin-bottom: 1px;
        }

        h4 {
            color: blue;
            display: inline;
        }
    </style>

    <style>
        table {
            width: 800px;
            background-color: white;
            margin-top: 5px;
            margin-bottom: 5px;
        }

        table, th, td {
            border: 1px solid #CCCCFF;
        }

        th, td {
            padding: 5px;
            text-align: center;
        }
    </style>

</head>
<body bgcolor='white'>

<h4>�����m�߱ĥ� EL ���g�k����:</h4>
<table id="table-1">
    <tr>
        <td>
            <h3>�Ҧ��ӫ~��� - listAllProduct.jsp</h3>
            <h4><a href="select_administrator.jsp"><i class="fa-solid fa-house">�^����</i></a></h4>
        </td>
    </tr>
</table>

<table>
    <tr>
        <th>�ӫ~�s��</th>
        <th>�ӫ~���O�s��</th>
        <th>�ӫ~�W��</th>
        <th>�ӫ~��T</th>
        <th>�ؤo</th>
        <th>�C��</th>
        <th>�ӫ~���</th>
        <th>�ӫ~���A</th>
        <th>�ӫ~�w��X�ƶq</th>
        <th>�����`�H��</th>
        <th>�����`�P��</th>
        <th>�ק�</th>
        <th>�R��</th>
    </tr>
    <%@ include file="page1.file" %>
    <c:forEach var="productVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">

        <tr>
            <td>${productVO.pNo}</td>
            <td>${productVO.pCatNo}</td>
            <td>${productVO.pName}</td>
            <td>${productVO.pInfo}</td>
            <td>${productVO.pSize}</td>
            <td>${productVO.pColor}</td>
            <td>${productVO.pPrice}</td>
            <td>${productVO.pStat}</td>
            <td>${productVO.pSalQty}</td>
            <td>${productVO.pComPeople}</td>
            <td>${productVO.pComScore}</td>
            <td>
                <form METHOD="post" ACTION="<%=request.getContextPath()%>/product/product.do"
                      style="margin-bottom: 0px;">
                    <button type="submit">
                        <i class="fa-solid fa-pen-to-square"></i>
                        <input type="hidden" name="pNo" value="${productVO.pNo}">
                        <input type="hidden" name="action" value="getOne_For_Update">
                </form>
            </td>
            <td>
                <form id="deleteForm" method="post" action="<%=request.getContextPath()%>/product/product.do" style="margin-bottom: 0px;">
                    <button type="button" onclick="confirmDelete()">
                        <i class="fa-solid fa-trash-can"></i>
                        <input type="hidden" name="pNo" value="${productVO.pNo}">
                        <input type="hidden" name="action" value="delete">
                    </button>
                </form>
            </td>
        </tr>
    </c:forEach>
</table>
<%@ include file="page2.file" %>

<script>
    function confirmDelete() {
        if (confirm("�T�w�n�R���ܡH")) {
            document.getElementById("deleteForm").submit(); // �����?
            alert("�R�����\�I"); // �u�X���\�T��!
        }
    }
</script>

</body>
</html>