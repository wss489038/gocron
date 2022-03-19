<template>
  <div v-cloak>
    <el-menu
      :default-active="currentRoute"
      mode="horizontal"
      background-color="#334157"
      text-color="#fff"
      active-text-color="#ffd04b"
      router>
      <el-row>
        <el-col style="width: 150px; text-align: center;">
          <el-menu-item>
            <i class="el-icon-loading"></i><i class="el-icon-star-on"></i><i class="el-icon-loading"></i>
          </el-menu-item>
        </el-col>
        <el-col :span="2">
          <el-menu-item index="/task">
            <i class="el-icon-menu"></i>
            <span slot="title">任务管理</span>
          </el-menu-item>
        </el-col>
        <el-col :span="2">
          <el-menu-item index="/host">
            <i class="el-icon-upload"></i>
            <span slot="title">任务节点</span>
          </el-menu-item>
        </el-col>
        <el-col :span="2">
          <el-menu-item v-if="this.$store.getters.user.isAdmin" index="/user">
            <i class="el-icon-service"></i>
            <span slot="title">用户管理</span>
          </el-menu-item>
        </el-col>
        <el-col :span="2">
          <el-menu-item v-if="this.$store.getters.user.isAdmin" index="/system">
            <i class="el-icon-setting"></i>
            <span slot="title">系统管理</span>
          </el-menu-item>
        </el-col>
        <el-col style="float:right; width: 110px">
          <el-submenu v-if="this.$store.getters.user.token" index="userStatus">
            <template slot="title">
              <span slot="title">{{this.$store.getters.user.username}}</span>
            </template>
              <el-menu-item index="/user/edit-my-password">
                <i class="el-icon-edit-outline"></i>
                <span>修改密码</span>
              </el-menu-item>
              <el-menu-item @click="logout" index="/user/logout">
                <i class="el-icon-circle-close-outline"></i>
                <span>退出</span>
              </el-menu-item>
          </el-submenu>
        </el-col>
      </el-row>
    </el-menu>
  </div>
</template>

<script>

export default {
  name: 'app-nav-menu',
  data () {
    return {}
  },
  computed: {
    currentRoute () {
      if (this.$route.path === '/') {
        return '/task'
      }
      const segments = this.$route.path.split('/')
      return `/${segments[1]}`
    }
  },
  methods: {
    logout () {
      this.$store.commit('logout')
      this.$router.push('/')
    }
  }
}
</script>
