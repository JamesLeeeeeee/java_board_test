<%@page import="java.io.PrintWriter"%>
<%@page import="bbs.BbsDAO"%>
<%@page import="bbs.Bbs" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
		<%
		// 현재 세션 상태를 체크한다.
		String userID= null;
		if(session.getAttribute("userID") !=null){
			userID=(String)session.getAttribute("userID");
		}
		
		//로그인 상태만 글쓸 쓸 수 있다.
		if(userID == null){
			PrintWriter script= response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 후 글쓰기가 가능합니다.')");
			script.println("location.href='login.jsp'");
			script.println("</script>");	
		}
		int bbsID=0;
		if(request.getParameter("bbsID") !=null){
			bbsID= Integer.parseInt(request.getParameter("bbsID"));
		}
		if(bbsID==0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
		//bbsID에서 userID확인 후 권한 확인
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		if(!userID.equals(bbs.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");	
		}else
		{
			//글 삭제 기능
			BbsDAO bbsDAO = new BbsDAO();
			int result = bbsDAO.delete(bbsID);
			if(result==-1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글 삭제에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
		}
		else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글이 삭제 됐습니다.')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
		
	}
	%>
</body>
</html>