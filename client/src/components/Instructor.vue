<template>
  <b-container>
    <div class="page-header">
      <b-row>
        <b-col lg="12" md="8" sm="4">
          <h2 class="d-inline">{{ className }}</h2>
          <b-button variant="success" size="lg" class="float-right">
            Instructor: {{ instructorName }}
          </b-button>
        </b-col>
      </b-row>
    </div>
    <br />
    <div class="row">
      <div
        class="col-lg-4 col-md-4"
        v-for="buf in instructorBuffers"
        v-bind:key="buf.id"
      >
        <div class="card border-primary mb-4">
          <div class="card-header">Group {{ buf.id }}</div>
          <div class="card-body">
            <div v-bind:id="buf.div"></div>
          </div>
        </div>
      </div>
    </div>
    <div v-if="instructorBuffers.length == 0">
      <i>No groups yet, enroll students in the <router-link :to="{ name: 'Settings' }">Settings</router-link> tab.</i>
    </div>
  </b-container>
</template>

<script lang="ts">
import { Component, Vue } from "vue-property-decorator";
import BufferService from "@/services/buffer";
import { Buffer } from "../types";

@Component
export default class Instructor extends Vue {
  name = "Instructor";

  initializedBuffers: Set<number> = new Set();

  get instructorName() {
    return this.$store.getters.currentUser.firstName;
  }
  get className() {
    return this.$store.getters.currentClass.class;
  }
  get instructorBuffers(): Array<Buffer> {
    const bufs = this.$store.getters.instructorBuffers;
    console.log("instructorBuffers", bufs);
    return bufs;
  }

  initBuffers(all: boolean) {
    for (const buf of this.instructorBuffers) {
      if (all || !this.initializedBuffers.has(buf.id)) {
        BufferService.initBuf(buf, this.$store.getters.currentClass.language);
        this.initializedBuffers.add(buf.id);
      }
    }
  }

  mounted() {
    this.initBuffers(true);
  }

  updated() {
    this.initBuffers(false);
  }
}
</script>
