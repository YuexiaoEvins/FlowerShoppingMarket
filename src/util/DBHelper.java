package util;
 
import java.sql.Connection;
import java.sql.DriverManager;

 
public class DBHelper {
    private static final String DRIVER = "com.mysql.jdbc.Driver";
    private static final String URL = "jdbc:mysql://localhost:3306/shopping?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "";
    private static Connection con = null;
    
    //加载数据库驱动
    static {
        try{
            Class.forName(DRIVER);
        }catch(Exception ex){
            ex.printStackTrace();
        }
    }
     
    //单例模式返回数据库连接对象
    public static Connection getConnection() throws Exception{
        if(con==null){

            con = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            return con;
        }
        return con;
    }
}