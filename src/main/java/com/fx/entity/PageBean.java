package com.fx.entity;

import java.io.Serializable;
import java.util.List;

public class PageBean implements Serializable{

    private static final long serialVersionUID = -6890763480992354638L;

    private int currentPage;
    private int pageSize;
    private int count;
    private int totalPage;
    private List<?> list;

    public PageBean(int currentPage, int pageSize, int count, int totalPage, List<?> list) {
        this.currentPage = currentPage;
        this.pageSize = pageSize;
        this.count = count;
        this.totalPage = totalPage;
        this.list = list;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public List<?> getList() {
        return list;
    }

    public void setList(List<?> list) {
        this.list = list;
    }
}
