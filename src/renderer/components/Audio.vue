<template>
  <div>
    <audio
      id="audio-long-break"
      ref="audio-long-break"
      :src="'./static/audio/mixkit-happy-bells-notification-937.mp3'"
    ></audio>
    <audio
      id="audio-short-break"
      ref="audio-short-break"
      :src="'./static/audio/mixkit-ding-notification-cut.mp3'"
    ></audio>
    <audio
      id="audio-work"
      ref="audio-work"
      :src="'./static/audio/mixkit-bell-notification-933-cut.mp3'"
    ></audio>
    <audio
      id="audio-tick"
      ref="audio-tick"
      :src="'./static/audio/tick.mp3'"
    ></audio>
    <!-- new audios-->
    <audio
      id="audio-reset"
      ref="audio-reset"
      :src="'./static/audio/mixkit-magic-marimba-2820-cut.mp3'"
    ></audio>
    <audio
      id="audio-start"
      ref="audio-start"
      :src="'./static/audio/mixkit-doorbell-tone-2864-cut.mp3'"
    ></audio>
    <audio
      id="audio-pause"
      ref="audio-pause"
      :src="'./static/audio/mixkit-elevator-tone-2863.mp3'"
    ></audio>
  </div>
</template>

<script>
import { EventBus } from '@/utils/EventBus'

export default {
  data() {
    return {
      audioLongBreak: null,
      audioTick: null,
      audioShortBreak: null,
      audioWork: null,
      audioReset: null,
      audioStart: null,
      audioPause: null
    }
  },

  computed: {
    // store getters
    currentRound() {
      return this.$store.getters.currentRound
    },
    tickSounds() {
      return this.$store.getters.tickSounds
    },
    tickSoundsDuringBreak() {
      return this.$store.getters.tickSoundsDuringBreak
    },
    volume() {
      return this.$store.getters.volume * 0.01
    }
  },

  mounted() {
    // Volume attribute on audio is not supported
    // and must be set programmatically.
    EventBus.$on('ready-long-break', () => {
      this.$refs['audio-long-break'].volume = this.volume
      this.$refs['audio-long-break'].play()
    })

    EventBus.$on('ready-short-break', () => {
      this.$refs['audio-short-break'].volume = this.volume
      this.$refs['audio-short-break'].play()
    })

    EventBus.$on('timer-tick', () => {
      this.$refs['audio-tick'].volume = this.volume
      const isBreak = this.currentRound === 'short-break' || this.currentRound === 'long-break'
      if (isBreak && !this.tickSoundsDuringBreak) return
      if (!isBreak && !this.tickSounds) return
      this.$refs['audio-tick'].play()
    })

    EventBus.$on('ready-work', () => {
      this.$refs['audio-work'].volume = this.volume
      this.$refs['audio-work'].play()
    })

    EventBus.$on('action-reset', () => {
      this.$refs['audio-reset'].volume = this.volume
      this.$refs['audio-reset'].play()
    })

    EventBus.$on('action-start', () => {
      this.$refs['audio-start'].volume = this.volume
      this.$refs['audio-start'].play()
    })

    EventBus.$on('action-pause', () => {
      this.$refs['audio-pause'].volume = this.volume
      this.$refs['audio-pause'].play()
    })
  }
}
</script>
