var express = require("express");
var router = express.Router();

var medidaController = require("../controllers/medidaController");

router.get("/ultimas/:idMedida", function (req, res) {
    medidaController.buscarUltimasMedidas(req, res);
});

router.get("/tempo-real/:idMedida", function (req, res) {
    medidaController.buscarMedidasEmTempoReal(req, res);
})

module.exports = router;