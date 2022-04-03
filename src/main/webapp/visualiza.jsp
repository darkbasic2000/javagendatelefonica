<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--Import Google Icon Font-->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!-- Compiled and minified JavaScript -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
        <!-- Compiled and minified CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css" />        
        <title>JSP Visualiza</title>
    </head>
    
    <body>
        
        <div class="container">
            <jsp:include page="navbar.jsp"></jsp:include>
            <div class="row">
                <div class="col s6 center">
                    <i class="large material-icons" style="font-size: 256px;">
                        <c:choose>
                            <c:when test="${contato.foto == 'nopicture.png'}">
                                <i class="material-icons" style="font-size: 256px;">not_interested</i>
                            </c:when>
                            <c:otherwise>
                                <img src="<c:out value="${requestScope.path}${contato.foto}" />" width="400" height="400" />
                            </c:otherwise>
                        </c:choose>                        
                    </i>
                    <h6 class="center" style="font-weight: bold; margin-top: 0;">Foto de <c:out value="${contato.nome}" /></h6>
                </div>                
                <form method="post" action="ContatoController?query=index">  
                    <div class="col s6">
                        <input type="hidden" id="id" name="id" value="${requestScope.contato.id}" readonly />
                        <div class="input-field col s12">
                            <i class="material-icons prefix">account_circle</i>
                            <input name="nome" id="nome" type="text" class="validate" required maxlength="30" value="${requestScope.contato.nome}" readonly>
                            <label for="nome">Nome</label>
                        </div>
                        <div class="input-field col s12">
                            <i class="material-icons prefix">local_phone</i>
                            <input name="telefone" id="telefone" type="text" class="validate" required maxlength="14" value="${requestScope.contato.telefone}" readonly>
                            <label for="telefone">Telefone</label>
                        </div>
                        <div class="input-field col s12">
                            <i class="material-icons prefix">email</i>
                            <input name="email" id="email" type="email" class="validate" required maxlength="40" value="${requestScope.contato.email}" readonly>
                            <label for="email">E-mail</label>
                        </div>
                        <div class="input-field col s12">
                            <div class="file-field input-field">
                                <div class="btn black disabled">
                                    <i class="material-icons">photo_camera</i>
                                    <input type="file" name="foto" id="foto" readonly />
                                </div>
                                <div class="file-path-wrapper">
                                    <input class="file-path validate" type="text" placeholder="Foto" />
                                </div>                                
                            </div>
                        </div>
                        <div class="input-field col s12">
                            <button class="btn waves-effect waves-light purple right" type="submit">Voltar
                                <i class="material-icons right">keyboard_backspace</i>
                            </button>
                        </div>
                        <div class="input-field col s12">
                            <c:if test="${requestScope.error != null}">
                                <c:out value="${requestScope.error}" />
                            </c:if>
                        </div>
                    </div>
                </form>                              
            </div>
        </div>
    
    </body>
    
</html>