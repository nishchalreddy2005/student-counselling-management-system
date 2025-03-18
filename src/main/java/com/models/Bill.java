package com.models;

import java.sql.Date;

public class Bill {
    private int readingId;
    private String meterNumber;
    private int unitsConsumed;
    private Date readingDate;
    private String paymentstatus;

    // Getters and setters
    public int getReadingId() {
        return readingId;
    }

    public void setReadingId(int readingId) {
        this.readingId = readingId;
    }

    public String getMeterNumber() {
        return meterNumber;
    }

    public void setMeterNumber(String meterNumber) {
        this.meterNumber = meterNumber;
    }

    public int getUnitsConsumed() {
        return unitsConsumed;
    }

    public void setUnitsConsumed(int unitsConsumed) {
        this.unitsConsumed = unitsConsumed;
    }

    public Date getReadingDate() {
        return readingDate;
    }

    public void setReadingDate(Date readingDate) {
        this.readingDate = readingDate;
    }
    public String getPaymentStatus() {
    	return paymentstatus;
    }
    
    public void setPaymentStatus(String paymentstatus) {
    	this.paymentstatus = paymentstatus;
    }
}
