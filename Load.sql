CREATE TABLE "PERS_DOCENTE"
(
  ci_pers integer NOT NULL,
  nombre character varying(50) NOT NULL,
  disponibilidad integer NOT NULL
);

CREATE TABLE "PERS_MAIL"
(
  mail character varying(70) NOT NULL,
  ci_pers integer NOT NULL
      
);

CREATE TABLE "PERS_TLF"
(
  tlf integer NOT NULL,
  ci_pers integer NOT NULL
      
);

CREATE TABLE "AUX_DOCENTE"
(
  ci_pers integer NOT NULL 
      
);

CREATE TABLE "AUX_CREDEN"
(
  credencial character varying(50) NOT NULL,
  ci_pers integer NOT NULL
      
);

CREATE TABLE "ESTUDIANTE"
(
  ci_pers integer NOT NULL,
  beca boolean NOT NULL,
  indice real NOT NULL,
  carne integer NOT NULL,
  tipo character varying(50)
);

CREATE TABLE "AYUD_ACADEM"
(
  ci_pers integer NOT NULL,
  nivel character varying(50) NOT NULL
);

CREATE TABLE "PREPARADOR"
(
  ci_pers integer NOT NULL,
  tipo character varying(50) NOT NULL
  );

CREATE TABLE "PROFESIONAL"
(
  ci_pers integer NOT NULL,
  tipo character varying(50) NOT NULL,
  categoria character varying(50) NOT NULL
  );

CREATE TABLE "PROFES_TIT"
(
  tit_especialidad character varying(50) NOT NULL,
  ci_pers integer NOT NULL,
  tit_nivel character varying(50) NOT NULL
  );

CREATE TABLE "TRIMESTRE"
(
  anio integer NOT NULL,
  periodo character varying(50) NOT NULL,
  fecha_ini date,
  fecha_fin date
  );

CREATE TABLE "MATERIA"
(
  codigo character varying(6) NOT NULL,
  tipo character varying(50) NOT NULL,
  creditos integer NOT NULL,
  cadena boolean NOT NULL,
  grado character varying(50) NOT NULL,
  horas_practica integer,
  horas_laboratorio integer,
  horas_teoria integer
);

CREATE TABLE "CONTRATO"
(
  ci_pers integer NOT NULL,
  fecha_ini date NOT NULL,
  fecha_fin date NOT NULL,
  dedicacion character varying(30) NOT NULL
);

CREATE TABLE "OFERTA"
(
  anio integer NOT NULL,
  periodo character varying(50) NOT NULL,
  tipo character varying(50) NOT NULL
);

CREATE TABLE "BLOQUE"
(
  codigo character varying(6) NOT NULL,
  tipo character varying(50) NOT NULL,
  anio integer NOT NULL,
  periodo character varying(50) NOT NULL,
  letra character varying(1) NOT NULL,
  horario character varying(3) NOT NULL,
  cupo_max integer NOT NULL
);

CREATE TABLE "ASIGNA"
(
  ci_pers integer NOT NULL,
  anio integer NOT NULL,
  codigo character varying(6) NOT NULL,
  periodo character varying(50) NOT NULL,
  tipo character varying(50) NOT NULL,
  seccion integer NOT NULL,
  num_estud integer NOT NULL,
  encargado boolean NOT NULL,
  num_aprob integer NOT NULL
);

CREATE TABLE "INSCRIBE"
(
  ci_pers integer NOT NULL,
  codigo character varying(6) NOT NULL,
  nota integer NOT NULL
  );

CREATE TABLE "PREFIERE"
(
  ci_pers integer NOT NULL,
  tipo character varying(50) NOT NULL,
  anio integer NOT NULL,
  periodo character varying(50) NOT NULL,
  codigo character varying(6) NOT NULL,
  letra character varying(1) NOT NULL,
  cod_asig character varying(6) NOT NULL
  );

CREATE TABLE "REQUIERE"
(
  codigo character varying(6) NOT NULL,
  codigo_pre character varying(6) NOT NULL
       
);

CREATE TABLE "SE_UBICA"
(
  anio integer NOT NULL,
  periodo character varying(50) NOT NULL,
  codigo character varying(6) NOT NULL
  );