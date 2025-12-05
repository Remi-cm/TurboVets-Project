import { Component, OnInit, OnDestroy, ViewChild, ElementRef } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-logs',
  standalone: true,
  imports: [CommonModule],
  template: `
    <div class="bg-white dark:bg-slate-800 rounded-xl shadow-sm border border-slate-200 dark:border-slate-700 flex flex-col h-full transition-colors duration-300">
      <div class="p-6 border-b border-slate-100 dark:border-slate-700 flex justify-between items-center">
        <h2 class="text-lg font-bold text-slate-800 dark:text-white">Live Logs Panel</h2>
        <span class="flex h-3 w-3">
          <span class="animate-ping absolute inline-flex h-3 w-3 rounded-full bg-emerald-400 opacity-75"></span>
          <span class="relative inline-flex rounded-full h-3 w-3 bg-emerald-500"></span>
        </span>
      </div>
      
      <div class="p-4 flex-1">
        <div #logContainer 
             class="bg-slate-950 rounded-lg p-4 font-mono text-xs h-64 md:h-full overflow-y-auto text-emerald-400 shadow-inner border border-slate-900 custom-scrollbar">
          <div *ngFor="let log of logs" class="mb-1.5 flex hover:bg-slate-900 p-0.5 rounded px-1 transition-colors">
            <span class="opacity-40 select-none mr-3 text-slate-500">{{ log.time }}</span> 
            <span class="break-all">{{ log.message }}</span>
          </div>
          <div class="animate-pulse opacity-50 mt-2">_</div>
        </div>
      </div>
    </div>
  `
})
export class LogsComponent implements OnInit, OnDestroy {
  logs: {time: string, message: string}[] = [];
  intervalId: any;
  @ViewChild('logContainer') private logContainer!: ElementRef;

  ngOnInit() {
    this.addLog('Initializing TurboVets daemon...');
    this.intervalId = setInterval(() => {
      this.addLog(this.getRandomLog());
    }, 2500);
  }

  ngOnDestroy() {
    if (this.intervalId) clearInterval(this.intervalId);
  }

  addLog(message: string) {
    const time = new Date().toLocaleTimeString('en-US', {hour12: false, hour:'2-digit', minute:'2-digit', second:'2-digit'});
    this.logs.push({ time, message });
    if (this.logs.length > 30) this.logs.shift(); 
    
    setTimeout(() => {
      if (this.logContainer) {
        this.logContainer.nativeElement.scrollTop = this.logContainer.nativeElement.scrollHeight;
      }
    }, 100);
  }

  getRandomLog() {
    const msgs = [
      '✓ Built build/app/outputs/flutter-apk/app-debug.apk',
      'Launching lib/main.dart on sdk gphone64 arm64 in debug mode...',
      '[INFO] Connection established 192.168.0.101',
      '[WARN] Latency spike detected (150ms)',
      'GET /api/v2/tickets/sync 200 OK',
      '[SUCCESS] Database backup completed',
      'Auth token refreshed for John Doe',
      '[DEBUG] Rendering frame 4022',
      'POST /webhook/turbovets_stripe_events 201 Created'
    ];
    return msgs[Math.floor(Math.random() * msgs.length)];
  }
}