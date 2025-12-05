import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-knowledgebase',
  standalone: true,
  imports: [CommonModule, FormsModule],
  template: `
    <div class="bg-white dark:bg-slate-800 rounded-xl shadow-sm border border-slate-200 dark:border-slate-700 flex flex-col h-full transition-colors duration-300">
      <div class="p-6 border-b border-slate-100 dark:border-slate-700">
        <h2 class="text-lg font-bold text-slate-800 dark:text-white">Knowledgebase Editor</h2>
      </div>

      <div class="p-6 flex-1 flex flex-col space-y-5">
        <div>
          <label class="block text-xs font-bold text-slate-400 uppercase tracking-wide mb-1.5">Title</label>
          <input type="text" [(ngModel)]="title" 
                 class="w-full bg-slate-50 dark:bg-slate-900 border border-slate-200 dark:border-slate-600 rounded-lg px-4 py-2.5 
                        text-slate-800 dark:text-slate-100
                        focus:ring-2 focus:ring-primary-500 focus:border-transparent outline-none transition-all"
                 placeholder="e.g. How to reset password">
        </div>

        <div class="flex-1 flex flex-col">
          <label class="block text-xs font-bold text-slate-400 uppercase tracking-wide mb-1.5">Content (Markdown)</label>
          <textarea [(ngModel)]="content" 
                    class="w-full flex-1 bg-slate-50 dark:bg-slate-900 border border-slate-200 dark:border-slate-600 rounded-lg px-4 py-3 
                           text-slate-800 dark:text-slate-100 font-mono text-sm leading-relaxed
                           focus:ring-2 focus:ring-primary-500 focus:border-transparent outline-none transition-all resize-none"
                    placeholder="Start writing..."></textarea>
        </div>

        <div class="flex justify-between items-center pt-2">
          <span class="text-xs text-slate-400">Last saved: Just now</span>
          <button class="bg-primary-500 hover:bg-primary-600 text-white font-semibold py-2 px-6 rounded-lg 
                         flex items-center shadow-lg shadow-primary-500/20 active:scale-95 transition-all">
            <span class="mr-2">💾</span> Save
          </button>
        </div>
      </div>
    </div>
  `
})
export class KnowledgebaseComponent {
  title = '# New Incident or bug Report';
  content = '**Incident #9898**\n\n- We can document it here and save..';
}