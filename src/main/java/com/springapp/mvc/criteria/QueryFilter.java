package com.springapp.mvc.criteria;

import org.hibernate.Query;

import java.util.Set;

public class QueryFilter {

    private String whereQuery;

    Set<QueryParameter> parameters;

    Set<QueryParameterList> parameterLists;

    public QueryFilter(String whereQuery, Set<QueryParameter> parameters, Set<QueryParameterList> parameterLists) {
        this.whereQuery = whereQuery;
        this.parameters = parameters;
        this.parameterLists = parameterLists;
    }

    public void fillParameters(Query query) {

        if (parameters != null) {
            for (QueryParameter qp : parameters) {
                query.setParameter( qp.getName(), qp.getValue() );
            }
        }

        if (parameterLists != null) {
            for (QueryParameterList qpList : parameterLists) {
                query.setParameterList(qpList.getName(), qpList.getValueList());
            }
        }
    }

    public String getWhereQuery() {
        return whereQuery;
    }

    public void setWhereQuery(String whereQuery) {
        this.whereQuery = whereQuery;
    }

    public Set<QueryParameter> getParameters() {
        return parameters;
    }

    public void setParameters(Set<QueryParameter> parameters) {
        this.parameters = parameters;
    }

    public Set<QueryParameterList> getParameterLists() {
        return parameterLists;
    }

    public void setParameterLists(Set<QueryParameterList> parameterLists) {
        this.parameterLists = parameterLists;
    }
}