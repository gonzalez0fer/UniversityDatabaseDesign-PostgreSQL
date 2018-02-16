ALTER TABLE "PERS_DOCENTE" ADD CONSTRAINT "PERS_DOCENTE_pkey" PRIMARY KEY (ci_pers);

ALTER TABLE "PERS_MAIL" ADD CONSTRAINT "PERS_MAIL_pkey" PRIMARY KEY (mail, ci_pers) ,
 ADD CONSTRAINT "PERS_MAIL_ci_pers_fkey" FOREIGN KEY (ci_pers)
 	 REFERENCES "PERS_DOCENTE" (ci_pers);


ALTER TABLE "PERS_TLF" ADD CONSTRAINT  "PERS_TLF_pkey" PRIMARY KEY (tlf, ci_pers),
  ADD CONSTRAINT "PERS_TLF_ci_pers_fkey" FOREIGN KEY (ci_pers)
      REFERENCES "PERS_DOCENTE" (ci_pers) ;

ALTER TABLE "AUX_DOCENTE" ADD   CONSTRAINT "AUX_DOCENTE_pkey" PRIMARY KEY (ci_pers),
  ADD CONSTRAINT "AUX_DOCENTE_ci_pers_fkey" FOREIGN KEY (ci_pers)
      REFERENCES "PERS_DOCENTE" (ci_pers);

ALTER TABLE "AUX_CREDEN" ADD    CONSTRAINT "AUX_CREDEN_pkey" PRIMARY KEY (credencial, ci_pers),
  ADD CONSTRAINT "AUX_CREDEN_ci_pers_fkey" FOREIGN KEY (ci_pers)
      REFERENCES "AUX_DOCENTE" (ci_pers);

ALTER TABLE "ESTUDIANTE" ADD    CONSTRAINT "ESTUDIANTE_pkey" PRIMARY KEY (ci_pers),
  ADD CONSTRAINT "ESTUDIANTE_ci_pers_fkey" FOREIGN KEY (ci_pers)
      REFERENCES "PERS_DOCENTE" (ci_pers),
  ADD CONSTRAINT "ESTUDIANTE_carne_key" UNIQUE (carne),
  ADD CONSTRAINT "ESTUDIANTE_check" CHECK ((NOT tipo = 'preparador' OR indice >= 3.5) AND (NOT tipo = 'ayudante_academico' OR indice >= 4)),
  ADD CONSTRAINT "DOM_TIPO" CHECK (tipo='preparador' or tipo='ayudante_academico' or tipo=NULL),
  ADD CONSTRAINT "INDICE_MENOR_QUE_5" CHECK (indice <= 5);

ALTER TABLE "AYUD_ACADEM" ADD   CONSTRAINT "AYUD_ACADEM_pkey" PRIMARY KEY (ci_pers),
  ADD CONSTRAINT "AYUD_ACADEM_ci_pers_fkey" FOREIGN KEY (ci_pers)
      REFERENCES "ESTUDIANTE" (ci_pers),
  ADD CONSTRAINT "NIVEL" CHECK (nivel = 'MAESTRIA' OR nivel = 'DOCTORADO');

ALTER TABLE "PREPARADOR" ADD CONSTRAINT "PREPARADOR_pkey" PRIMARY KEY (ci_pers),
  ADD CONSTRAINT "PREPARADOR_ci_pers_fkey" FOREIGN KEY (ci_pers)
      REFERENCES "ESTUDIANTE" (ci_pers),
  ADD CONSTRAINT "TIPO" CHECK (tipo = 'ACTIVIDADES-DOCENTES' OR tipo = 'ACTIVIDADES-APOYO');

ALTER TABLE "PROFESIONAL" ADD CONSTRAINT "PROFESIONAL_pkey" PRIMARY KEY (ci_pers),
  ADD CONSTRAINT "PROFESIONAL_ci_pers_fkey" FOREIGN KEY (ci_pers)
      REFERENCES "PERS_DOCENTE" (ci_pers),
  ADD CONSTRAINT "CATEGORIA" CHECK (categoria = 'I' OR categoria = 'II' OR categoria = 'III' OR categoria = 'IV' OR categoria = 'V' OR categoria = 'ASISTENTE' OR categoria = 'AGREGADO' OR categoria = 'ASOCIADO' OR categoria = 'TITULAR'),
  ADD CONSTRAINT "TIPO" CHECK (tipo = 'PC' OR tipo = 'PE' OR tipo = 'SP' OR tipo = 'PJ');


ALTER TABLE "PROFES_TIT" ADD CONSTRAINT "PROFES_TIT_pkey" PRIMARY KEY (tit_especialidad, ci_pers, tit_nivel),
  ADD CONSTRAINT "PROFES_TIT_ci_pers_fkey" FOREIGN KEY (ci_pers)
      REFERENCES "PROFESIONAL" (ci_pers) ,
  ADD CONSTRAINT "TIT_NIVEL" CHECK (tit_nivel = 'TERCERO' OR tit_nivel = 'CUARTO' OR tit_nivel = 'QUINTO');

  ALTER TABLE "TRIMESTRE" ADD CONSTRAINT "TRIMESTRE_pkey" PRIMARY KEY (anio, periodo),
  ADD CONSTRAINT "FECHAS" CHECK (fecha_ini < fecha_fin),
  ADD CONSTRAINT "PERIODO" CHECK (periodo = 'ENERO-MARZO' OR periodo = 'ABRIL-JULIO' OR periodo = 'SEPTIEMBRE-DICIEMBRE');

  ALTER TABLE "MATERIA" ADD CONSTRAINT "MATERIA_pkey" PRIMARY KEY (codigo),
  ADD CONSTRAINT "GRADO" CHECK (grado = 'PREGRADO' OR grado = 'POSTGRADO'),
  ADD CONSTRAINT "HORAS_No_0" CHECK (horas_laboratorio <> 0 OR horas_teoria <> 0),
  ADD CONSTRAINT "SI_ES_CADENA_ES_PRE_ELEC" CHECK (NOT cadena = true OR tipo = 'ELECTIVA-AREA' AND grado = 'PREGRADO'),
  ADD CONSTRAINT "TIPO" CHECK (tipo = 'OBLIGATORIA' OR tipo = 'ELECTIVA-AREA' OR tipo = 'ELECTIVA-LIBRE');

  ALTER TABLE "OFERTA" ADD  CONSTRAINT "OFERTA_pkey" PRIMARY KEY (anio, periodo, tipo),
  ADD CONSTRAINT "OFERTA_anio_fkey" FOREIGN KEY (anio, periodo)
      REFERENCES "TRIMESTRE" (anio, periodo) ,
  ADD CONSTRAINT "PERIODO" CHECK (periodo = 'ENERO-MARZO' OR periodo = 'ABRIL-JULIO' OR periodo = 'SEPTIEMBRE-DICIEMBRE'),
  ADD CONSTRAINT "TIPO" CHECK (tipo = 'PREOFERTA' OR tipo = 'OFERTA');

  ALTER TABLE "CONTRATO" ADD CONSTRAINT "CONTRATO_pkey" PRIMARY KEY (ci_pers, fecha_ini, fecha_fin),
  ADD CONSTRAINT "CONTRATO_ci_pers_fkey" FOREIGN KEY (ci_pers)
      REFERENCES "PERS_DOCENTE" (ci_pers),
  ADD CONSTRAINT "DEDICACION" CHECK (dedicacion = 'EXCLUSIVA' OR dedicacion = 'CONVENCIONAL' OR dedicacion = 'INTEGRAL'),
  ADD CONSTRAINT "FECHAS" CHECK (fecha_ini < fecha_fin);

  ALTER TABLE "BLOQUE" ADD CONSTRAINT "BLOQUE_pkey" PRIMARY KEY (codigo, tipo, anio, periodo, letra),
  ADD CONSTRAINT "BLOQUE_anio_fkey" FOREIGN KEY (anio, periodo, tipo)
      REFERENCES "OFERTA" (anio, periodo, tipo) ,
  ADD CONSTRAINT "BLOQUE_codigo_fkey" FOREIGN KEY (codigo)
      REFERENCES "MATERIA" (codigo) ,
  ADD CONSTRAINT "PERIODO-CUPOMAX" CHECK ((periodo = 'ENERO-MARZO' OR periodo = 'ABRIL-JULIO' OR periodo = 'SEPTIEMBRE-DICIEMBRE') AND cupo_max >= 0);

  ALTER TABLE "ASIGNA" ADD CONSTRAINT "ASIGNA_pkey" PRIMARY KEY (ci_pers, anio, codigo, periodo),
  ADD CONSTRAINT "ASIGNA_anio_fkey" FOREIGN KEY (anio, periodo)
      REFERENCES "TRIMESTRE" (anio, periodo) ,
  ADD CONSTRAINT "ASIGNA_ci_pers_fkey" FOREIGN KEY (ci_pers)
      REFERENCES "PERS_DOCENTE" (ci_pers) ,
  ADD CONSTRAINT "ASIGNA_codigo_fkey" FOREIGN KEY (codigo)
      REFERENCES "MATERIA" (codigo) ,
  ADD CONSTRAINT "DEBEN_SER_POSITIVOS" CHECK (num_estud >= 0 AND seccion >= 0 AND num_aprob >= 0),
  ADD CONSTRAINT "PERIODO" CHECK (periodo = 'ENERO-MARZO' OR periodo = 'ABRIL-JULIO' OR periodo = 'SEPTIEMBRE DICIEMBRE'),
  ADD CONSTRAINT "TIPO" CHECK (tipo = 'definitiva' OR tipo = 'tentativa');

  ALTER TABLE "INSCRIBE" ADD CONSTRAINT "INSCRIBE_pkey" PRIMARY KEY (ci_pers, codigo),
  ADD CONSTRAINT "INSCRIBE_ci_pers_fkey" FOREIGN KEY (ci_pers)
      REFERENCES "ESTUDIANTE" (ci_pers)  ,
  ADD CONSTRAINT "INSCRIBE_codigo_fkey" FOREIGN KEY (codigo)
      REFERENCES "MATERIA" (codigo) ,
  ADD CONSTRAINT "NOTA_ENTRE_0_5" CHECK (nota >= 0 AND nota <= 5);

  ALTER TABLE "PREFIERE" ADD CONSTRAINT "PREFIERE_pkey" PRIMARY KEY (ci_pers, tipo, anio, periodo, codigo, letra, cod_asig),
  ADD CONSTRAINT "PREFIERE_ci_pers_fkey" FOREIGN KEY (ci_pers)
      REFERENCES "PERS_DOCENTE" (ci_pers)  ,
  ADD CONSTRAINT "PREFIERE_cod_asig_fkey" FOREIGN KEY (cod_asig)
      REFERENCES "MATERIA" (codigo) ,
  ADD CONSTRAINT "PREFIERE_codigo_fkey" FOREIGN KEY (codigo, tipo, anio, periodo, letra)
      REFERENCES "BLOQUE" (codigo, tipo, anio, periodo, letra) ,
  ADD CONSTRAINT "PERIODO" CHECK (periodo = 'ENERO-MARZO' OR periodo = 'ABRIL-JULIO' OR periodo = 'SEPTIEMBRE-DICIEMBRE');

  ALTER TABLE "REQUIERE" ADD CONSTRAINT "REQUIERE_pkey" PRIMARY KEY (codigo, codigo_pre),
  ADD CONSTRAINT "REQUIERE_codigo_fkey" FOREIGN KEY (codigo)
      REFERENCES "MATERIA" (codigo) ,
  ADD CONSTRAINT "REQUIERE_codigo_pre_fkey" FOREIGN KEY (codigo_pre)
      REFERENCES "MATERIA" (codigo) ;

ALTER TABLE "SE_UBICA" ADD CONSTRAINT "SE_UBICA_pkey" PRIMARY KEY (anio, periodo, codigo),
  ADD CONSTRAINT "SE_UBICA_anio_fkey" FOREIGN KEY (anio, periodo)
      REFERENCES "TRIMESTRE" (anio, periodo) ,
  ADD CONSTRAINT "SE_UBICA_codigo_fkey" FOREIGN KEY (codigo)
      REFERENCES "MATERIA" (codigo) ,
  ADD CONSTRAINT "PERIODO" CHECK (periodo = 'ENERO-MARZO' OR periodo = 'ABRIL-JULIO' OR periodo = 'SEPTIEMBRE-DICIEMBRE');










