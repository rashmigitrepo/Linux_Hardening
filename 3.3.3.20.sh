---
- name: 3.3.3.20 Files with Owner/User
  hosts: your_target_hosts
  become: true
  tasks:
    - name: Ensure no unowned files or directories exist 
      block:
        - name: Ensure no unowned files or directories exist (Automated) | Find
          shell: df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -nouser
          register: output_unowned_3.3.3.20
        - name: Ensure no unowned files or directories exist (Automated) | Fix
          file:
            path: "{{ item }}"
            owner: root
            group: root
          loop: "{{ output_unowned_3.3.3.20.stdout_lines }}"
          when: output_unowned_3.3.3.20.stdout_lines is defined and output_unowned_3.3.3.20.stdout_lines | length > 0


    - name: Ensure no ungrouped files or directories exist (Automated)
      block:
        - name: Ensure no ungrouped files or directories exist (Automated) | Find
          shell: df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -nogroup
          register: output_ungrouped_3.3.3.20
        - name: Ensure no ungrouped files or directories exist (Automated) | Fix
          file:
            path: "{{ item }}"
            owner: root
            group: root
          loop: "{{ output_ungrouped_3.3.3.20.stdout_lines }}"
          when: output_ungrouped_3.3.3.20.stdout_lines is defined and output_ungrouped_3.3.3.20.stdout_lines | length > 0
