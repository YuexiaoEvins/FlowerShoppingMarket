package util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Iterator;

import util.*;

public class UserDAO{
    //��ȡ���ݿ������е���Ʒ����
	
    public ArrayList<User> getAllUser(){
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        ArrayList<User> list = new ArrayList<>();  //��Ʒ����
        
        try{
            conn = DBHelper.getConnection();
            String sql = "select * from shopping.myuser;";  //sql���
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            while(rs.next()){
                User user = new User();
                user.setUid(rs.getString("id"));
                user.setPsw(rs.getString("psw"));
                user.setUname(rs.getString("name"));
                user.setAge(rs.getInt("age"));
                user.setPhone(rs.getString("phone"));
                user.setUcount(rs.getInt("ucount"));
                user.setAddress(rs.getString("province")+rs.getString("city")+rs.getString("address"));
                list.add(user);  //���뼯��
            }
            
            return list;  //���ؼ���
            
        }catch(Exception ex){
            ex.printStackTrace();
            return null;
        }finally{
            //�ͷ����ݼ�����
            if(rs!=null){
                try{
                    rs.close();
                    rs = null;
                }catch(Exception ex){
                    ex.printStackTrace();
                }
            }
            //�ͷ�������
            if(stmt!=null){
                try{
                    stmt.close();
                    stmt=null;
                }catch(Exception ex){
                    ex.printStackTrace();
                }
            }
        }
    }
    
    //�����û��˺Ż�ȡ�û���Ϣ
    public User getUserByUid(String uid){
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try{
            conn = DBHelper.getConnection();
            String sql = "select * from shopping.myuser where id=?;";  //sql���
            stmt = conn.prepareStatement(sql);
            stmt.setString(1,uid);
            rs = stmt.executeQuery();
            if(rs.next()){
                User user = new User();
                user.setUid(rs.getString("id"));
                user.setPsw(rs.getString("psw"));
                user.setUname(rs.getString("name"));
                user.setAge(rs.getInt("age"));
                user.setPhone(rs.getString("phone"));
                user.setUcount(rs.getInt("ucount"));
                user.setAddress(rs.getString("province")+rs.getString("city")+rs.getString("address"));
                return user;
            }else{
                return null;
            }
            
        }catch(Exception ex){
            ex.printStackTrace();
            return null;
        }finally{
            //�ͷ����ݼ�����
            if(rs!=null){
                try{
                    rs.close();
                    rs = null;
                }catch(Exception ex){
                    ex.printStackTrace();
                }
            }
            //�ͷ�������
            if(stmt!=null){
                try{
                    stmt.close();
                    stmt=null;
                }catch(Exception ex){
                    ex.printStackTrace();
                }
            }
        }
    }
    
    public void InsertUser(User user){
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try{
        	conn = DBHelper.getConnection();
        	String sql = "insert into shopping.myuser(id,name,psw,age,phone,province,city,address) values(?,?,?,?,?,?,?,?)";
	        stmt = conn.prepareStatement(sql);
	        stmt.setString(1,user.getUid());
	        stmt.setString(2, user.getUname());
	        stmt.setString(3, user.getPsw());
	        stmt.setInt(4, user.getAge());
	        stmt.setString(5, user.getPsw());
	        stmt.setString(6, user.getProvince());
	        stmt.setString(7, user.getCity());
	        stmt.setString(8, user.getAddress());
	        stmt.executeUpdate();;
                        
        }catch(Exception ex){
            ex.printStackTrace();
        }finally{
            //�ͷ����ݼ�����
            if(rs!=null){
                try{
                    rs.close();
                    rs = null;
                }catch(Exception ex){
                    ex.printStackTrace();
                }
            }
            //�ͷ�������
            if(stmt!=null){
                try{
                    stmt.close();
                    stmt=null;
                }catch(Exception ex){
                    ex.printStackTrace();
                }
            }
        }
    }
    
    public void UpdateUserInfo(User user) {
    	Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;       
        try{       	
            conn = DBHelper.getConnection();
            String sql = "Update shopping.myuser set name=?,age=?,phone=?,province=?,city=?,address=? where id=?";  //sql���
            stmt = conn.prepareStatement(sql);  
            stmt.setString(1,user.getUname());
            stmt.setInt(2, user.getAge());
            stmt.setString(3, user.getPhone());
            stmt.setString(4, user.getProvince());
            stmt.setString(5, user.getCity());
            stmt.setString(6, user.getAddress());
            stmt.setString(7, user.getUid());
            stmt.executeUpdate();
            
        }catch(Exception ex){
            ex.printStackTrace();
        }finally{
            //�ͷ����ݼ�����
            if(rs!=null){
                try{
                    rs.close();
                    rs = null;
                }catch(Exception ex){
                    ex.printStackTrace();
                }
            }
            //�ͷ�������
            if(stmt!=null){
                try{
                    stmt.close();
                    stmt=null;
                }catch(Exception ex){
                    ex.printStackTrace();
                }
            }
        }
	}
    
    public void UpdateUserPsw(User user) {
    	Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;       
        try{       	
            conn = DBHelper.getConnection();
            String sql = "Update shopping.myuser set psw=? where id=?";  //sql���
            stmt = conn.prepareStatement(sql);
            stmt.setString(1,user.getPsw());
            stmt.setString(2, user.getUid());
            stmt.executeUpdate();
            
        }catch(Exception ex){
            ex.printStackTrace();
        }finally{
            //�ͷ����ݼ�����
            if(rs!=null){
                try{
                    rs.close();
                    rs = null;
                }catch(Exception ex){
                    ex.printStackTrace();
                }
            }
            //�ͷ�������
            if(stmt!=null){
                try{
                    stmt.close();
                    stmt=null;
                }catch(Exception ex){
                    ex.printStackTrace();
                }
            }
        }
	}

}