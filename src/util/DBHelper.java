package util;
 
import java.sql.Connection;
import java.sql.DriverManager;

 
public class DBHelper {
    private static final String DRIVER = "com.mysql.jdbc.Driver";
    private static final String URL = "jdbc:mysql://localhost:3306/shopping?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "";
    private static Connection con = null;
    
    //�������ݿ�����
    static {
        try{
            Class.forName(DRIVER);
        }catch(Exception ex){
            ex.printStackTrace();
        }
    }
     
    //����ģʽ�������ݿ����Ӷ���
    public static Connection getConnection() throws Exception{
        if(con==null){

            con = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            return con;
        }
        return con;
    }
}