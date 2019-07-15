package util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.Items;
import util.DBHelper;
import util.*;

public class ItemsDAO{
    //��ȡ���ݿ������е���Ʒ����
    public ArrayList<Items> getAllItems(){
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        ArrayList<Items> list = new ArrayList<>();  //��Ʒ����
        
        try{
            conn = DBHelper.getConnection();
            String sql = "select * from shopping.items;";  //sql���
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            while(rs.next()){
                Items item = new Items();
                item.setId(rs.getInt("id"));
                item.setName(rs.getString("name"));
                item.setCity(rs.getString("city"));
                item.setPrice(rs.getInt("price"));
                item.setNumber(rs.getInt("number"));
                item.setPicture(rs.getString("picture"));
                list.add(item);  //���뼯��
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
    
    //������Ʒ��Ż�ȡ��Ʒ����
    public Items getItemById(int id){
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try{
            conn = DBHelper.getConnection();
            String sql = "select * from shopping.items where id=?;";  //sql���
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1,id);
            rs = stmt.executeQuery();
            if(rs.next()){
                Items item = new Items();
                item.setId(rs.getInt("id"));
                item.setName(rs.getString("name"));
                item.setCity(rs.getString("city"));
                item.setPrice(rs.getInt("price"));
                item.setNumber(rs.getInt("number"));
                item.setPicture(rs.getString("picture"));
                return item;
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
    
    public void ChangeCount(int id,int count) {
    	Connection conn = null;
        PreparedStatement stmt = null;
        PreparedStatement stmt2 = null;
        ResultSet rs = null;
        
        try{
        	
            conn = DBHelper.getConnection();
            String sql = "select * from shopping.items where id=?;";  //sql���
            String sql2 = "Update shopping.items set number=? where id=?";  //sql���
            stmt = conn.prepareStatement(sql);
            stmt2 = conn.prepareStatement(sql2);
            stmt.setInt(1,id);
            rs = stmt.executeQuery();
            if(rs.next()){
                int total = rs.getInt("number");
                total-=count;
                stmt2.setInt(2,id);
                stmt2.setInt(1,total);
                System.out.println(id);
                System.out.println(total);
                int res = stmt2.executeUpdate();
                System.out.println(res);
            }
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