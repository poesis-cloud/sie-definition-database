begin;

create schema if not exists sie_definition;

create table if not exists sie_definition.definition_documents (
  id bigserial primary key,
  doc_type text not null,
  doc jsonb not null,
  created_at timestamptz not null default now()
);

create index if not exists definition_documents_doc_gin
  on sie_definition.definition_documents
  using gin (doc);

commit;
