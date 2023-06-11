var database = require("../database/config");

function buscarUltimasMedidas(idPais, limite_linhas) {

    instrucaoSql = ''

    if (process.env.AMBIENTE_PROCESSO == "producao") {
        instrucaoSql = `select top ${limite_linhas}
        temepraturaMedida as temperatura, 
        poder_compraMedida as poder_compra,  
        religiosidadeMedida as religiosidade,
        multiculturaMedida as multicultura,
        inflacaoMedida as inflacao
                    from medida
                    where fk_pais = ${idPais}
                    order by idMedida desc`;
    } else if (process.env.AMBIENTE_PROCESSO == "desenvolvimento") {
        instrucaoSql = `select 
        temepraturaMedida as temperatura, 
        poder_compraMedida as poder_compra,  
        religiosidadeMedida as religiosidade,
        multiculturaMedida as multicultura,
        inflacaoMedida as inflacao
                    from medida
                    where fk_pais = ${idPais}
                    order by idPais desc limit ${limite_linhas}`;
    } else {
        console.log("\nO AMBIENTE (produção OU desenvolvimento) NÃO FOI DEFINIDO EM app.js\n");
        return
    }

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal(idPais) {

    instrucaoSql = ''

    if (process.env.AMBIENTE_PROCESSO == "producao") {
        instrucaoSql = `select top 1
        temepraturaMedida as temperatura, 
        poder_compraMedida as poder_compra,  
        religiosidadeMedida as religiosidade,
        multiculturaMedida as multicultura,
        inflacaoMedida as inflacao,
        fk_pais,
                    from medida where fk_pais = ${idPais} 
                    order by id desc`;

    } else if (process.env.AMBIENTE_PROCESSO == "desenvolvimento") {
        instrucaoSql = `select 
        temepraturaMedida as temperatura, 
        poder_compraMedida as poder_compra,  
        religiosidadeMedida as religiosidade,
        multiculturaMedida as multicultura,
        inflacaoMedida as inflacao,
        fk_pais,
                    from medida where fk_pais = ${idPais} 
                    order by id desc limit 1`;
    } else {
        console.log("\nO AMBIENTE (produção OU desenvolvimento) NÃO FOI DEFINIDO EM app.js\n");
        return
    }

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}


module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal
}
