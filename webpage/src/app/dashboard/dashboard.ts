import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Tickets } from '../tickets/tickets';
import { LogsComponent } from '../logs/logs';
import { KnowledgebaseComponent } from '../knowledgebase/knowledgebase';

@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [
    CommonModule, 
    Tickets, 
    LogsComponent, 
    KnowledgebaseComponent
  ],
  template: `
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 h-full pb-6">
      
      <!-- Ticket Viewer -->
      <div class="lg:col-span-2 min-h-[400px]">
        <app-tickets></app-tickets>
      </div>

      <!-- Knowledgebase -->
      <div class="min-h-[400px]">
        <app-knowledgebase></app-knowledgebase>
      </div>

      <!-- Logs -->
      <div class="min-h-[400px]">
        <app-logs></app-logs>
      </div>
      
    </div>
  `
})
export class DashboardComponent {}