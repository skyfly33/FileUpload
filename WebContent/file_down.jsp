<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ page import="java.io.File"%>
<%@ page import="java.io.*" %>
<%
	String fileName = request.getParameter("file_name");
	
	String savePath = "upload";
	ServletContext context = getServletContext();
	String sDownloadPath = context.getRealPath(savePath);
	String sFilePath = sDownloadPath+"/"+fileName;
	
	byte b[] = new byte[4096];
	File oFile = new File(sFilePath);
	
	FileInputStream in = new FileInputStream(sFilePath);
	
	String sMimeType = getServletContext().getMimeType(sFilePath);
	System.out.println("sMimeType>>>"+ sMimeType);
	
	//octet-stream은 8비트로 된 일련의 데이터를 뜻합니다. 지정되지 않은 파일 형식을 의미합니다.
	if(sMimeType == null)sMimeType = "application/octet-stream";
	response.setContentType(sMimeType);
	
	//한글 업로드 (이 부분이 한글 파일명이 깨지는 것을 방지해 줍니다.)
	String sEncoding = new String(fileName.getBytes("euc-kr"),"8859_1");
	
	//이 부분이 모든 파일 링크를 클랙했을 때 다운로드 화면이 출력되게 처리하는 부분입니다.
	response.setHeader("Content-Disposition", "attachment;filename="+sEncoding);
	
	ServletOutputStream out2 = response.getOutputStream();
	int numRead;
	
	//바이트 배열 b의 0번부터 numRead번까지 브라우저로 출력.
	while((numRead = in.read(b, 0, b.length)) != -1){
		out2.write(b, 0, numRead);
	}
	
	out2.flush();
	out2.close();
	in.close();
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

</body>
</html>