CREATE OR ALTER PROCEDURE  CTE_DUPLICAR( CTE_ORIGEM                       INTEGER
                             , COD_CTE_NOVA                     INTEGER )
AS
/*DECLARE VARIABLE cod_cte_nova Integer;  */
DECLARE VARIABLE cod_id Integer; 
BEGIN
   /*select * from cte_duplicar_cte(:cte_origem) */
   /*  into :cod_cte_nova; */
   /*cod_cte_nova =  */
        
    /* CTE_COMP */
    FOR SELECT COD_CTE_COMP FROM CTE_COMP 
      WHERE COD_CTE = :cte_origem 
      INTO :cod_id
    do begin 
      INSERT INTO CTE_COMP (COD_CTE_COMP, COD_CTE,
        COMP_NOME, COMP_VALOR)
      SELECT GEN_ID(GEN_CTE_COMP_ID,1), :cod_cte_nova,
          COMP_NOME, COMP_VALOR 
        FROM CTE_COMP 
        WHERE COD_CTE_COMP = :cod_id;
    end

    /* CTE_MOTORISTA */
    FOR SELECT COD_CTE_MOTORISTA FROM CTE_MOTORISTA 
      WHERE COD_CTE = :cte_origem 
      INTO :cod_id
    do begin
      INSERT INTO CTE_MOTORISTA (COD_CTE_MOTORISTA,
        COD_CTE, CPF, NOME)
      SELECT GEN_ID(GEN_CTE_MOTORISTA_ID, 1),
        :cod_cte_nova, CPF, NOME 
        FROM CTE_MOTORISTA 
        WHERE COD_CTE_MOTORISTA = :cod_id;
    end
      
    /* CTE_NFE  */
    FOR SELECT COD_CTE_NFE FROM CTE_NFE 
      WHERE CTE_NFE = :cte_origem 
      INTO :cod_id     
    do begin
      INSERT INTO CTE_NFE (COD_CTE_NFE, CTE_NFE, CHAVE,
        PIN, DPREV)
      SELECT GEN_ID(GEN_CTE_NFE_ID, 1), :cod_cte_nova, CHAVE,
          PIN, DPREV
        FROM CTE_NFE 
        WHERE COD_CTE_NFE = :cod_id;
    end
      
    /* CTE_QC */
    FOR SELECT COD_CTE_QC FROM CTE_QC 
      WHERE COD_CTE = :cte_origem 
      INTO :cod_id
    do begin    
      INSERT INTO CTE_QC (COD_CTE_QC, COD_CTE, UNID,
        MEDIDA, QUANT)
      SELECT GEN_ID(GEN_CTE_QC_ID, 1), :cod_cte_nova, UNID,
        MEDIDA, QUANT
        FROM CTE_QC 
        WHERE COD_CTE_QC = :cod_id;
    end

    /* CTE_SEGURO */
    FOR SELECT COD_CTE_SEGURO FROM CTE_SEGURO 
      WHERE COD_CTE = :cte_origem 
      INTO :cod_id
    do begin    
      INSERT INTO CTE_SEGURO (COD_CTE_SEGURO, COD_CTE,
        RESP, NOME_SEGURADORA, NUMERO_APOLICE, VALOR,
        NUMERO_AVERBACAO)
      SELECT GEN_ID(GEN_CTE_SEGURO_ID, 1), :cod_cte_nova, 
          RESP, NOME_SEGURADORA, NUMERO_APOLICE, VALOR,
          NUMERO_AVERBACAO
        FROM CTE_SEGURO 
        WHERE COD_CTE_SEGURO = :cod_id;
    end
    
    /* CTE_VEICULOS     */
    FOR SELECT COD_CTE_VEICULOS FROM CTE_VEICULOS 
      WHERE COD_CTE = :cte_origem 
      INTO :cod_id
    do begin    
      INSERT INTO CTE_VEICULOS (COD_CTE_VEICULOS,
        COD_CTE, CINT, RENAVAM, PLACA, TARA, CAPKG,
        CAPM3, TPROD, TPCAR, TPVEIC, TPPROP, UF, CNPJ,
        RNTRC, NOME, IE, VTPPROP, VUF, VALINFCARGA)
      SELECT GEN_ID(GEN_CTE_VEICULOS_ID, 1), :cod_cte_nova, 
          CINT, RENAVAM, PLACA, TARA, CAPKG,
          CAPM3, TPROD, TPCAR, TPVEIC, TPPROP, UF, CNPJ,
          RNTRC, NOME, IE, VTPPROP, VUF, VALINFCARGA
        FROM CTE_VEICULOS 
        WHERE COD_CTE_VEICULOS = :cod_id;
    end
end
