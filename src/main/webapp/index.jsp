<%@page import="com.mycompany.javagendatelefonica.dao.ContatoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
    </head>
    
    <body>
        
        <% 
            RequestDispatcher rd = request.getRequestDispatcher("list.jsp");
            ContatoDAO dao = new ContatoDAO();
            request.setAttribute("contatos", dao.list(1));
            request.setAttribute("query", "list");
            rd.forward(request, response);
        %>
        
    </body>
    
</html>