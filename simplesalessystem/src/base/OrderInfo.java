package base;

import java.io.Serializable;

public class OrderInfo implements Serializable {
    private String description;
    private double price;
    private String orderTime;
    private String sequenceNumber;
    private String orderStatus;
    private boolean isNew;

    public OrderInfo(String description, double price, String orderTime, String sequenceNumber, String orderStatus, boolean isNew) {
        this.description = description;
        this.price = price;
        this.orderTime = orderTime;
        this.sequenceNumber = sequenceNumber;
        this.orderStatus = orderStatus;
        this.isNew = isNew;
    }

    // Getters and Setters
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getOrderTime() {
        return orderTime;
    }

    public boolean getIsNew(){
        return isNew;
    }

    public void setOrderTime(String orderTime) {
        this.orderTime = orderTime;
    }

    public String getSequenceNumber() {
        return sequenceNumber;
    }

    public void setSequenceNumber(String sequenceNumber) {
        this.sequenceNumber = sequenceNumber;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public void setIsNew(boolean isNew){
        this.isNew = isNew;
    }
}