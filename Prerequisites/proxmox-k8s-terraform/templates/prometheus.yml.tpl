#global:
#  scrape_interval: 15s
#
#scrape_configs:
#  - job_name: 'kubernetes-masters'
#    static_configs:
#      %{ for ip in master_ips ~}
#      - targets: ['${ip}:9100']
#      %{ endfor ~}
#
#  - job_name: 'kubernetes-workers'
#    static_configs:
#      %{ for ip in worker_ips ~}
#      - targets: ['${ip}:9100']
#      %{ endfor ~}
#
#  - job_name: 'proxmox'
#    metrics_path: '/pve'
#    static_configs:
#      - targets: ['${pm_api_url}']
#    relabel_configs:
#      - source_labels: [__address__]
#        target_label: __param_target
#      - source_labels: [__param_target]
#        target_label: instance
#      - target_label: __address__
#        replacement: ${pm_api_url}:9221
