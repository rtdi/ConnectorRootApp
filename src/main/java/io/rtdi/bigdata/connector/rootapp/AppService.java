package io.rtdi.bigdata.connector.rootapp;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/apps.json")
public class AppService extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static long BROWSER_CACHING_IN_SECS = 3600L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AppService() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		long expiry = System.currentTimeMillis() + BROWSER_CACHING_IN_SECS*1000;
		response.setDateHeader("Expires", expiry);
		response.setHeader("Cache-Control", "max-age="+ BROWSER_CACHING_IN_SECS);
		response.setContentType("text/json");
		String configdirpath = request.getServletContext().getRealPath("WEB-INF");
		File webappsdir = new File(configdirpath).getParentFile().getParentFile();
		File[] apps = webappsdir.listFiles();


		try (ServletOutputStream out = response.getOutputStream();) {
			out.println("{ \"apps\": [");
			for (File f : apps) {
				if (f.isDirectory() && !f.getName().equals("ROOT") && !f.getName().equals("openui5")) {
					String connectorname = f.getName();
					out.println("		{"); 
					out.println("			\"name\": \"Connector " + connectorname + "\","); 
					out.println("			\"description\": \"Login to this connector (Webserver default is: rtdi/rtdi!io)\","); 
					out.println("			\"tooltip\": null,"); 
					out.println("			\"href\": \"./" + connectorname + "\","); 
					out.println("			\"icon\": \"sap-icon://visits\""); 
					out.println("		},"); 
				}
			}
			out.println("		{"); 
			out.println("			\"name\": \"Setup Help\","); 
			out.println("			\"description\": \"Details about the webserver setup, security hardening,...\","); 
			out.println("			\"tooltip\": null,"); 
			out.println("			\"href\": \"https://github.com/rtdi/ConnectorRootApp\","); 
			out.println("			\"icon\": \"sap-icon://sys-help\""); 
			out.println("		}"); 
			out.println("] }");
		}
	}

}

