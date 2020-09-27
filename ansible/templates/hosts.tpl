[dbservers]
${db1_public_ip}
${db2_public_ip}

[master]
${db1_public_ip}

[slave]
${db2_public_ip}
