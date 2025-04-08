-- Projet Osiris
-- création de schéma et rôle
-- le 5/3/2025

---- création du schéma ----
create schema if not exists osiris;

---- creation des rôles utilisateur ----
-- accès uniquement en lecture
create role inc_u_osiris_ro with login password 'Kc3&zGYzDDSkJR59';
-- accès en écriture
create role inc_u_osiris_rw with login password 'qMbFRb4N9yA&D6$hyK';
-- accès en écriture uniquement pour alimenter le référentiel
create role inc_u_osiris_ref_rw with login password 'Geyd9XX?KeSBb4Dg$jP';

-- création de rôle technique (groupe)
-- accès uniquement en lecture
create role inc_g_osiris_ro with nologin;
-- accès en écriture
create role inc_g_osiris_rw with nologin;
-- accès en écriture uniquement pour alimenter le référentiel
create role inc_g_osiris_ref_rw with nologin;

---- affectation des utilisateurs dans les rôles ----
grant inc_g_osiris_ro to inc_u_osiris_ro;
grant inc_g_osiris_rw to inc_u_osiris_rw;
grant inc_g_osiris_ref_rw to inc_u_osiris_ref_rw;

------ Accès à la base ------
grant connect on database inc to inc_u_osiris_ro;
grant connect on database inc to inc_u_osiris_rw;
grant connect on database inc to inc_u_osiris_ref_rw;

---- affectation des rôles groupes au schéma avec cascade ----
grant usage on schema osiris to inc_g_osiris_ro;
grant usage on schema osiris to inc_g_osiris_ref_rw;
grant all on schema osiris to inc_g_osiris_rw;

---- grant sur les tables
grant all privileges on all tables in schema osiris to inc_g_osiris_rw;
-- À repasser à chaque création de table ----
grant select on all tables in schema osiris to inc_g_osiris_ro;
-- Grant sur la table de référence à compléter. --
-- grant all on table <osiris_ref> to inc_g_osiris_ref_rw


-- Table de test de droit à lancer avec inc_u_osiris_rw
--create table osiris.test_sdg (
--	id	char(5) not null,
--	code	varchar(40)
--	);
