package com.ahmeteminsaglik.ws.model.bloodresult;

public class ItemRangeValue {
    int lowBound, highBound;

    public ItemRangeValue(int lowBound, int highBound) {
        this.lowBound = lowBound;
        this.highBound = highBound;
    }

    public int getLowBound() {
        return lowBound;
    }

    public void setLowBound(int lowBound) {
        this.lowBound = lowBound;
    }

    public int getHighBound() {
        return highBound;
    }

    public void setHighBound(int highBound) {
        this.highBound = highBound;
    }
}
