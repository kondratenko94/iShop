package com.springapp.mvc.dto;

import java.util.List;

public class PaginationWrapper<T> {

    private List<T> list;
    private long count;
    private long maxCount;

    public PaginationWrapper() {}

    public PaginationWrapper(List<T> list, long count, long maxCount) {
        this.list = list;
        this.count = count;
        this.maxCount = maxCount;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof PaginationWrapper)) return false;

        PaginationWrapper<?> that = (PaginationWrapper<?>) o;

        if (count != that.count) return false;
        if (maxCount != that.maxCount) return false;
        return !(list != null ? !list.equals(that.list) : that.list != null);

    }

    @Override
    public int hashCode() {
        int result = list != null ? list.hashCode() : 0;
        result = 31 * result + (int) (count ^ (count >>> 32));
        result = 31 * result + (int) (maxCount ^ (maxCount >>> 32));
        return result;
    }

    public List<T> getList() {
        return list;
    }

    public void setList(List<T> list) {
        this.list = list;
    }

    public long getCount() {
        return count;
    }

    public void setCount(long count) {
        this.count = count;
    }

    public long getMaxCount() {
        return maxCount;
    }

    public void setMaxCount(long maxCount) {
        this.maxCount = maxCount;
    }

    public long getPagesCount() {
        return (long) Math.ceil( (double)maxCount / (double)count );
    }
}