resource "oci_core_instance" "connect" {
  display_name        = "connect-${count.index}"
  compartment_id      = var.compartment_ocid
  availability_domain = local.availability_domain
  shape               = var.broker["shape"]
  subnet_id           = oci_core_subnet.subnet.id
  fault_domain        = "FAULT-DOMAIN-${count.index % 3 + 1}"

  source_details {
    source_id   = var.images[var.region]
    source_type = "image"
  }
  shape_config {
      memory_in_gbs =var.broker["memory"]
      ocpus = var.broker["ocpus"]
  }
  create_vnic_details {
    subnet_id      = oci_core_subnet.subnet.id
    hostname_label = "connect-${count.index}"
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data = base64encode(
      join(
        "\n",
        [
          "#!/usr/bin/env bash",
          "version=${var.confluent["version"]}",
          "edition=${var.confluent["edition"]}",
          "zookeeperNodeCount=${var.zookeeper["node_count"]}",
          "brokerNodeCount=${var.broker["node_count"]}",
          "schemaRegistryNodeCount=${var.schema_registry["node_count"]}",
          file("../scripts/firewall.sh"),
          file("../scripts/install.sh"),
          file("../scripts/kafka_deploy_helper.sh"),
          file("../scripts/connect.sh"),
        ],
      ),
    )
  }

  count = var.connect["node_count"]
}

output "connect_public_ips" {
  value = join(",", oci_core_instance.connect.*.public_ip)
}

output "connect_url" {
  value = <<END
http://${oci_core_instance.connect[0].private_ip}:8083/connectors
END

}
