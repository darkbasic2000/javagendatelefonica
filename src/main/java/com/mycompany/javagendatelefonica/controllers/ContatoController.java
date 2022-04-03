package com.mycompany.javagendatelefonica.controllers;

import com.mycompany.javagendatelefonica.dao.ContatoDAO;
import com.mycompany.javagendatelefonica.pojos.Contato;
import java.io.File;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet(name = "ContatoController", urlPatterns = {"/ContatoController"})
@MultipartConfig(fileSizeThreshold=1024*1024*2, // 2MB 
                maxFileSize=1024*1024*10,   // 10MB
                maxRequestSize=1024*1024*10)    // 10MB
public class ContatoController extends HttpServlet {   
        
    // location to store file uploaded
    private static final String DIR = "fotos";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        
        String query = request.getParameter("query");
        
        if(query.equals("list")) {            
            String indice = request.getParameter("indice");
            if(indice == null || indice.equals("")) {
                indice = "1";
            }
            RequestDispatcher rd = request.getRequestDispatcher("list.jsp");
            ContatoDAO dao = new ContatoDAO();            
            request.setAttribute("paginas", dao.getNumberOfPages());
            request.setAttribute("indice", indice);
            request.setAttribute("contatos", dao.list(Integer.valueOf(indice)));
            request.setAttribute("path", request.getContextPath() + File.separator + DIR + File.separator);
            rd.forward(request, response);
        }
        else if(query.equals("new")) {
            RequestDispatcher rd = request.getRequestDispatcher("novo.jsp");            
            rd.forward(request, response);
        }
        else if(query.equals("salvar")) {
            Contato contato = new Contato();
            contato.setNome(request.getParameter("nome"));
            contato.setTelefone(request.getParameter("telefone"));
            contato.setEmail(request.getParameter("email"));
            ContatoDAO dao = new ContatoDAO();
            int resultado = dao.save(contato);
            if(resultado == 1) {
                RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
                request.setAttribute("contatos", dao.list(1));
                request.setAttribute("paginas", dao.getNumberOfPages());
                request.setAttribute("indice", "1");
                request.setAttribute("path", request.getContextPath() + File.separator + DIR + File.separator);
                rd.forward(request, response);
            }
            else {
                RequestDispatcher rd = request.getRequestDispatcher("novo.jsp");
                rd.forward(request, response);
            }
        }
        else if(query.equals("edita")) {
            Integer id = Integer.valueOf(request.getParameter("id"));
            ContatoDAO dao = new ContatoDAO();
            RequestDispatcher rd = request.getRequestDispatcher("edita.jsp");
            request.setAttribute("contato", dao.read(id));
            request.setAttribute("path", request.getContextPath() + File.separator + DIR + File.separator);
            rd.forward(request, response);
        }
        else if(query.equals("editar")) {
         
            Contato contato = new Contato();
            contato.setId(Integer.valueOf(request.getParameter("id")));
            contato.setNome(request.getParameter("nome"));
            contato.setTelefone(request.getParameter("telefone"));
            contato.setEmail(request.getParameter("email"));
            contato.setFoto(request.getParameter("foto"));
            
            Part filePart = request.getPart("foto");
            if(filePart.getSize() == 0) {
                contato.setFoto(null);
            }
            String type = filePart.getContentType();
            if(filePart.getSize() > 0 && !type.equals("image/jpeg") && !type.equals("image/jpg") && !type.equals("image/png")) {
                RequestDispatcher rd = request.getRequestDispatcher("/edita.jsp");
                request.setAttribute("error", "As imagens devem ser do tipo JPEG ou PNG");
                ContatoDAO dao = new ContatoDAO();
                request.setAttribute("contato", dao.read(contato.getId()));
                request.setAttribute("path", request.getContextPath() + File.separator + DIR + File.separator);
                rd.forward(request, response);
            }
            else {
                String fileName = filePart.getSubmittedFileName();
                fileName = "foto" + contato.getId() + ".png";
                for(Part part : request.getParts()) {
                    String path = request.getServletContext().getRealPath("") + File.separator + DIR + File.separator + fileName;
                    part.write(path);
                }
                if(filePart.getSize() > 0) {
                    contato.setFoto(fileName);
                }                
                ContatoDAO dao = new ContatoDAO();
                int resultado = dao.edit(contato);
                    if(resultado == 1) {                        
                        RequestDispatcher rd = request.getRequestDispatcher("list.jsp");
                        request.setAttribute("contatos", dao.list(1));
                        request.setAttribute("paginas", dao.getNumberOfPages());
                        request.setAttribute("indice", "1");
                        request.setAttribute("path", request.getContextPath() + File.separator + DIR + File.separator);
                        rd.forward(request, response);
                    }
                    else {                        
                        RequestDispatcher rd = request.getRequestDispatcher("edita.jsp");
                        request.setAttribute("error", "Erro ao tentar editar contato");
                        request.setAttribute("contato", dao.read(contato.getId()));
                        request.setAttribute("path", request.getContextPath() + File.separator + DIR + File.separator);
                        rd.forward(request, response);
                    }
                }                   
        }
        else if(query.equals("read")) {
            Integer id = Integer.valueOf(request.getParameter("id"));
            ContatoDAO dao = new ContatoDAO();
            RequestDispatcher rd = request.getRequestDispatcher("visualiza.jsp");
            request.setAttribute("contato", dao.read(id));
            request.setAttribute("path", request.getContextPath() + File.separator + DIR + File.separator);
            rd.forward(request, response);
        }
        else if(query.equals("delete")) {
            ContatoDAO dao = new ContatoDAO();
            request.setAttribute("contatos", dao.list(1));
            request.setAttribute("paginas", dao.getNumberOfPages());
            request.setAttribute("indice", "1");
            request.setAttribute("path", request.getContextPath() + File.separator + DIR + File.separator);
            dao.delete(Integer.valueOf(request.getParameter("id")));
            RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
            rd.forward(request, response);
        }
        else {
            ContatoDAO dao = new ContatoDAO();
            RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
            request.setAttribute("contatos", dao.list(1));
            request.setAttribute("paginas", dao.getNumberOfPages());
            request.setAttribute("indice", "1");
            request.setAttribute("path", request.getContextPath() + File.separator + DIR + File.separator);
            rd.forward(request, response);
        }
            
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
    
}