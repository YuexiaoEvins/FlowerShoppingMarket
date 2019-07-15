package util;

import java.util.ArrayList;

public class Order {
	private int oid;
	private int sum;
	private String uid;
	private String uname;
	private ArrayList<OrderItems> orderItemslist;
	
	public ArrayList<OrderItems> getOrderItemslist() {
		return orderItemslist;
	}
	public void setOrderItemslist(ArrayList<OrderItems> orderItemslist) {
		this.orderItemslist = orderItemslist;
	}
	public int getOid() {
		return oid;
	}
	public void setOid(int oid) {
		this.oid = oid;
	}
	public int getSum() {
		return sum;
	}
	public void setSum(int sum) {
		this.sum = sum;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
}
