<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>

<html>
    <head>
        <!--Import Google Icon Font-->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!-- Compiled and minified JavaScript -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
        <!-- Compiled and minified CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css" />        
        <title>JSP Index</title>
    </head>
    
    <body>
        
        <div class="container">
            <jsp:include page="navbar.jsp"></jsp:include>
                <div class="row">
                    <div class="col s12">
                        <table class="highlight">
                            <thead>
                                <tr>
                                    <th>Nome</th>
                                    <th>Telefone</th>
                                    <th>E-mail</th>
                                    <th>Foto</th>
                                    <th>Ações</th>
                                </tr>                    
                            </thead>
                            <tbody>
                            <c:forEach var="contato" items="${requestScope.contatos}">
                                <tr>
                                    <td style="word-break: break-all;"><c:out value="${contato.nome}" /></td>
                                    <td><c:out value="${contato.telefone}" /></td>
                                    <td><c:out value="${contato.email}" /></td>
                                    <c:choose>
                                        <c:when test="${contato.foto == 'nopicture.png'}">
                                            <td><i class="material-icons">not_interested</i></td>
                                        </c:when>
                                        <c:otherwise>
                                            <td><img src="<c:out value="${requestScope.path}" /><c:out value="${contato.foto}" />" width="50" height="50" /></td>
                                        </c:otherwise>
                                    </c:choose>                        
                                    <td colspan="2">
                                        <a class="waves-effect waves-light btn-small green tooltipped" data-position="bottom" data-tooltip="Ver informações"
                                           href="ContatoController?query=read&id=<c:out value="${contato.id}" />">
                                            <i class="material-icons">select_all</i>
                                        </a>
                                        <a class="waves-effect waves-light btn-small blue tooltipped" data-position="bottom" data-tooltip="Editar informações"
                                           href="ContatoController?query=edita&id=<c:out value="${contato.id}" />">
                                            <i class="material-icons">edit</i>
                                        </a>
                                        <a class="waves-effect waves-light btn-small modal-trigger red tooltipped" data-position="bottom" data-tooltip="Excluir contato"
                                           href="#modal1" onclick="selectId(<c:out value="${contato.id}" />)">
                                            <i class="material-icons">delete</i>
                                        </a>                            
                                    </td>
                                </tr>
                            </c:forEach>                            
                        </tbody>
                    </table>
                    <ul class="pagination center">
                        <c:forEach begin="0" end="${paginas}" varStatus="pagina">                            
                            <li class="<c:if test="${requestScope.indice-1 == pagina.index}"><c:out value="active" /></c:if>">
                                <a href="ContatoController?query=list&indice=<c:out value="${pagina.index+1}" />"><c:out value="${pagina.index+1}" /></a>
                            </li>
                        </c:forEach>
                    </ul>                          
                        
                    <c:if test="${requestScope.contatos.size() == 0}">
                        <div class="row yellow lighten-2 text-darken-2 right-align" style="font-size: 16px; font-weight: bold; padding: 5px; margin-top: 5px;">
                            <div class="col s12 right">
                                Ainda não há contatos registrados
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
            <div class="fixed-action-btn">
                <a class="btn-floating btn-large red tooltipped" data-delay="50" data-position="top" data-tooltip="Adicionar contato" href="novo.jsp">
                    <i class="large material-icons">add</i>
                </a>
            </div>
                <!-- Modal Structure -->
                <div id="modal1" class="modal">
                    <form method="post" action="ContatoController?query=delete">
                        <div class="modal-content">                        
                            <input type="hidden" name="id" id="id" />                            
                            <h4>Aviso</h4>
                            <p>Deseja realmenter deletar esse contato?</p>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="modal-close waves-effect waves-green btn-flat">Sim</button>
                            <button type="button" class="modal-close waves-effect waves-green btn-flat">Não</button>
                        </div>
                    </form>
                </div>
        </div>
                
                <script>
                    
                    function selectId(id) {
                        document.getElementById("id").value = id;
                    }
                    
                    document.addEventListener('DOMContentLoaded', function() {
                        var elems = document.querySelectorAll('.tooltipped');
                        var options = {
                            enterDelay : 205
                        };
                        var instances = M.Tooltip.init(elems, options);
                        // Modal
                        var modal = document.querySelectorAll('.modal');
                        var opcoes = {
                            
                        };
                        var instancias = M.Modal.init(modal, opcoes);                        
                    });                    
                </script>
        
    </body>
    
</html>