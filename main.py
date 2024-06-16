import streamlit as st
from langchain_model import get_langchain_db_chain

st.title("Query Your Database")

question = st.text_input("Question: ")

if question:
    chain = get_langchain_db_chain()
    #SQL_query = chain.return_sql
    response = chain.run(question)

    st.header("Answer")
    st.write(response)






