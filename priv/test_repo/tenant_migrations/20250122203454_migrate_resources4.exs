defmodule AshPostgres.TestRepo.TenantMigrations.MigrateResources4 do
  @moduledoc """
  Updates resources based on their most recent snapshots.

  This file was autogenerated with `mix ash_postgres.generate_migrations`
  """

  use Ecto.Migration

  def up do
    create table(:cross_tenant_post_links, primary_key: false, prefix: prefix()) do
      add(
        :source_id,
        references(:posts,
          column: :id,
          name: "cross_tenant_post_links_source_id_fkey",
          type: :uuid,
          prefix: "public"
        ),
        primary_key: true,
        null: false
      )

      add(
        :dest_id,
        references(:multitenant_posts,
          column: :id,
          name: "cross_tenant_post_links_dest_id_fkey",
          type: :uuid,
          prefix: prefix()
        ),
        primary_key: true,
        null: false
      )
    end
  end

  def down do
    drop(constraint(:cross_tenant_post_links, "cross_tenant_post_links_source_id_fkey"))

    drop(constraint(:cross_tenant_post_links, "cross_tenant_post_links_dest_id_fkey"))

    drop(table(:cross_tenant_post_links, prefix: prefix()))
  end
end
