package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

@WebServlet("/DownloadServlet")
public class DownloadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int BUFFER_SIZE = 4096;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Đường dẫn tuyệt đối đến thư mục lưu trữ tệp
        String filePath = getServletContext().getRealPath("") + File.separator + "documents";
        String fileName = request.getParameter("fileName");
        
        // Tạo đối tượng tệp
        File file = new File(filePath, fileName);
        if (!file.exists()) {
            // Hiển thị thông báo lỗi trên trang JSP
            request.setAttribute("errorMessage", "File not found: " + fileName);
            request.getRequestDispatcher("document").forward(request, response);
            return;
        }

        // Thiết lập thông tin phản hồi
        response.setContentType(getServletContext().getMimeType(file.getAbsolutePath()));
        response.setContentLength((int) file.length());
        response.setHeader("Content-Disposition", "attachment; filename=\"" + file.getName() + "\"");

        // Ghi tệp vào phản hồi
        FileInputStream inputStream = new FileInputStream(file);
        OutputStream outStream = response.getOutputStream();

        byte[] buffer = new byte[BUFFER_SIZE];
        int bytesRead = -1;

        while ((bytesRead = inputStream.read(buffer)) != -1) {
            outStream.write(buffer, 0, bytesRead);
        }

        inputStream.close();
        outStream.close();
    }
}
